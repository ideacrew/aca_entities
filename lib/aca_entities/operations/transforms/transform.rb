# rubocop:disable all
require 'oj'
require 'deep_merge'

module AcaEntities
  module Operations
    module Transforms

      class Context
        def initialize(contexts)
          @contexts = contexts
        end

        def resolve(key)
          OpenStruct.new @contexts.values.detect{|hash| hash[:name].to_s == key.to_s}
        end
      end

      class Transform < Oj::Saj

        BufferLength = 512

        attr_reader :namespaces, :namespace_record_delimiter, :array_namespaces, :container, :record, :record_index

        class << self
          def call(*args, &block)
            service = new(*args)
            service.namespace_record_delimiter = namespace_record_delimiter || [:no_key]
            service.call(&block)
          end

          def transform(payload)
            service = new
            service.namespace_record_delimiter = [:no_key]
            Oj.saj_parse(service, payload.to_json)
            service.record
          end

          def namespace_record_delimiter
            @namespace_record_delimiter # || ['$/']
          end

          def record_delimiter(delimiter)
            @namespace_record_delimiter = delimiter&.split('.')&.map(&:to_sym)
          end
        end

        def initialize(source = nil, options = {})
          @source = source
          @namespaces = []
          @array_namespaces = []
          @container = self.class.mapping_container
          @namespace_mappings = Hash.new
          @record_queue = []
          @wild_char_matchers = []
          @contexts = {}
          @transform_mode = options[:transform_mode]&.to_sym || :single
          @sub_records = []
          @namespaces_with_types = []
          @documents = []
        end

        def current_document
          @documents.last
        end

        def current_sub_record
          @sub_records.last
        end

        def namespace_record_delimiter=(delimiter)
          @namespace_record_delimiter = delimiter
        end

        def call(&block)
          @record_processor = block
          File.open(@source, 'r') {|f| Oj.saj_parse(self, f)}
        end

        def record_start(key)
          first_delimiter_match_index = @namespaces.index(namespace_record_delimiter[0])
          max_delimier_index = non_identifier_delimiters.keys.last
          @record_index = first_delimiter_match_index
          @record_index += max_delimier_index if max_delimier_index
          @record = {}
        end

        def record_end(key)
          @record_processor.call(record) if @record_processor

          remove_instance_variable(:@record_namespace_offset)
        end

        def hash_start(key)
          # puts "---------------Hash started ---#{key}"

          # binding.pry unless key

          key = :no_key unless key
          find_or_build_namespace_mappping_for(key) if defined? @record_namespace_offset

          @namespaces.push(key.to_sym)
          @namespaces_with_types.push(Hash[key.to_sym, :hash])

          if namespace_record_delimiter_matched?(@namespaces) && @array_namespaces.empty?
            @record_namespace_offset ||= @namespaces.dup
            record_start(key&.to_sym)
          end

          construct_document_with(key, :hash) if defined? @record_namespace_offset

          # @sub_records.push({}) if batch_process?

          add_new_elements(key) if defined? @record_namespace_offset
        end

        def hash_end(key)
          key = :no_key unless key

          matched = namespace_record_delimiter_matched?(@namespaces) && @array_namespaces.empty?
          # close_sub_record if record_builder && !record_builder.data_set.empty?
  
          @namespaces.pop

          @contexts.delete(key) unless batch_process?

          merge_documents(key, :hash)
          @namespaces_with_types.pop
        
          record_end(key&.to_sym) if matched
        end

        def array_start(key)
          # puts "---------------Array started ---#{key}"

          key = :no_key unless key
          @array_namespaces.push(key&.to_sym)
          @namespaces_with_types.push(Hash[key.to_sym, :array])
          construct_document_with(key, :array) if defined? @record_namespace_offset
          @array_records = [] if key
          @array_record = []
          @sub_records.push([]) if batch_process?
        end

        def array_end(key)
          @array_namespaces.pop
          @namespaces_with_types.pop
          sub_record = @sub_records.pop if batch_process?

          if key
            value = @array_records.empty? ? @array_record : @array_records
            unless batch_process? # Enable this
              unless value.empty?
                transform_data_for(key, value)
                # current_document.output_namespace = [] if current_document
                @array_record = []
              end
            end
          else
            @array_records.push(@array_record)
          end
          
          merge_documents(key, :array)
        end

        def add_value(value, key)
          # puts "-------Add Value--------_Key ---#{key.inspect}--- value #{value.inspect}"

          @array_record << value unless key

          # unless array_namespaces.empty?
          #   if current_sub_record && key && batch_process?
          #     t(:build_nested_hash)[current_sub_record, [], Hash[key.to_sym, value]]
          #   else
          #     @array_record << (key.nil? ? value : Hash[key.to_sym, value])
          #   end
          #   return
          # end

          return unless record_index
          transform_data_for(key, value)
        end

        private

        def construct_document_with(key, type)
          if batch_process?
            create_batch_document_for(key, type)
          else
            if key == :no_key
              create_document(element_namespaces.join('.'), key)
            else
              transformed_key = match_wildcard_chars(element_namespaces.join('.'))
              create_document_for(transformed_key, key, type, false)
            end
          end
        end

        def create_batch_document_for(key, type)
          document = if type == :hash
            AcaEntities::Operations::Transforms::HashDocument.new(key)
          elsif type == :array
            AcaEntities::Operations::Transforms::ArrayDocument.new(key)
          end

          document.source_namespace = element_namespaces
          document.output_namespace = element_namespaces
          document.parent_namespace = @documents.last&.output_namespace
          # puts "-------created #{document.inspect}"
          @documents.push(document)
        end

        def create_document_for(namespaced_key, key, type, regex = false)
          # puts "-----processing #{namespaced_key}---#{type}"

          return unless container.key?(namespaced_key)

          @wild_char_matchers.push(key) if regex

          mapping = container[namespaced_key]
          return unless mapping.type

          source_key = mapping.source_key 
          output_key = mapping.output_key

          document = if mapping.type == :hash
            AcaEntities::Operations::Transforms::HashDocument.new(key)
          elsif mapping.type == :array
            AcaEntities::Operations::Transforms::ArrayDocument.new(key)
          end

          document.source_namespace = source_key || element_namespaces
          document.output_namespace = output_key&.split('.') || element_namespaces
          document.parent_namespace = @documents.last&.output_namespace
          document.regex_key = key if regex
          # puts "----created #{document.inspect}"
          @documents.push(document)

          if mapping.type == :array && type == :hash
            document = AcaEntities::Operations::Transforms::HashDocument.new(:no_key)
            document.parent_namespace = @documents.last&.output_namespace
            document.regex_key = key if regex
             # puts "----created #{document.inspect}"
            @documents.push(document)
          end
        end

        def merge_documents(key, type)
          return if @documents.empty?
          # return unless key
          # puts "-----deleted #{@documents.last.inspect}---#{key}---#{type}"

          if type == :array
            return if current_document&.is_a?(AcaEntities::Operations::Transforms::HashDocument)
          end

          unless batch_process?
          if type == :hash && key != :no_key
            transformed_key = match_wildcard_chars(element_namespaces.join('.'))
            # puts "----------->>>> #{container.key?(transformed_key)}--for--#{transformed_key}" 
            return unless container.key?(transformed_key)
          end
        end


          recent_document = @documents.pop
           # puts "----deleted---#{recent_document.inspect}"

          if current_document
            # puts "#{recent_document.class}---Recent Document--#{recent_document.output}"
            # puts "#{current_document.class}---Current Document--#{current_document.output}"
            current_document.merge(recent_document.output)
          elsif recent_document
            record.deep_merge!(recent_document.output)
          end

          return if batch_process?

          namespaced_key = element_namespaces.join('.')
          transformed_key = match_wildcard_chars(namespaced_key)

          if container.key?(transformed_key)
            if container[transformed_key].type == :array && [:array, :hash].include?(type) && recent_document.root == :no_key
              merge_documents(key, type)
            end
          end
        end

        def element_namespaces
          @namespaces_with_types.map(&:keys).flatten[@record_namespace_offset.size..-1] || []
          # namespaces - @record_namespace_offset
        end

        def element_namespaces_with_types
          @namespaces_with_types[@record_namespace_offset.size..-1]
        end

        def add_new_elements(key)
          return if batch_process?
          namespaced_key = element_namespaces.join('.')
          namespaced_key = match_wildcard_chars(namespaced_key)
          process_add_namespaces(namespaced_key, key)
        end

        def process_add_namespaces(namespaced_key, key, namespace_add = false)
          return unless current_document
          create_document(namespaced_key, key) if namespace_add
     
          if namespaced_key == ''
            build_add_namespace('add_key', key)
          else
            build_add_namespace(namespaced_key, key)
          end

          merge_documents(key, :hash) if namespace_add
        end

        def create_document(namespaced_key, key)
          document = AcaEntities::Operations::Transforms::HashDocument.new(:no_key)
          document.output_namespace = namespaced_key.split('.')
          # puts "----created #{document.inspect}"
          @documents.push(document)
        end

        def build_add_namespace(namespaced_key, key)
          container.keys_under_namespace(namespaced_key).each do |key_under_ns|
            if container[key_under_ns].transproc_name == :add_namespace
              process_add_namespaces(key_under_ns, key, true)
            end

            if container[key_under_ns].transproc_name == :add_key
              input = {source_hash: Hash[key_under_ns.split('.').last.to_sym, nil]}
              input.merge!(context: Context.new(@contexts)) unless @contexts.empty?
              data = container[key_under_ns].call(input)[:source_hash]
              current_document.append(data)
            end
          end
        end

        def find_or_build_namespace_mappping_for(key)
          return unless defined? @record_namespace_offset

          key_with_namespace = (element_namespaces + [key]).compact.join('.')
          regex_key = (element_namespaces + ['*']).join('.') unless element_namespaces.compact.empty?

          initialize_new_record_for(regex_key, key) if regex_key
          initialize_new_record_for(key_with_namespace, key)
        end

        def initialize_new_record_for(namespaced_key, key)
          namespaced_key = match_wildcard_chars(namespaced_key)

          if container.key?(namespaced_key) && (record_builder.nil? || record_builder.root != namespaced_key)
            container_value = container[namespaced_key]
            @contexts[key] = container_value.context.merge(item: key) if container_value.context

            if container_value.type == :array
              # initialize_sub_record(namespaced_key, key)
              @wild_char_matchers.push(key) if namespaced_key.split('.').last == '*'
            end
          end
        end

        def namespace_record_delimiter_matched?(namespaces)
          return false if namespaces.empty?
          return false unless namespaces.index(namespace_record_delimiter[0])
          return true if namespace_record_delimiter.empty? && namespaces.compact.empty?

          namespace_subset = namespaces[namespaces.index(namespace_record_delimiter.first)..-1]
          return false unless namespace_subset.size == namespace_record_delimiter.size
          non_identifier_delimiters.all? {|index, delimiter| namespace_subset[index] == delimiter}
        end

        def non_identifier_delimiters
          return @non_identifier_dict if defined? @non_identifier_dict
          @non_identifier_dict = {}
          namespace_record_delimiter.each_with_index do |delimiter, index|
            @non_identifier_dict[index] = delimiter if delimiter != :identifier
          end
          @non_identifier_dict
        end

        def batch_process?
          @transform_mode == :batch
        end

        def transform_data_for(key, value)
          return unless defined? @record_namespace_offset
      
          if batch_process?
            input = if key
              t(:build_nested_hash)[{}, [], Hash[key.to_sym, value]]
            else
              value
            end
          else
            key_with_namespace = (element_namespaces + [key]).join('.')
            transformed_key = match_wildcard_chars(key_with_namespace.dup)
            record_unique_identifier = record_unique_identifier(key_with_namespace)

            return unless container.key?(transformed_key)

            input = if record_unique_identifier
                      t(:build_nested_hash)[{}, [], Hash[key.to_sym, value]]
                    else
                      t(:build_nested_hash)[{}, element_namespaces_with_types, Hash[key.to_sym, value]]
                    end

            data = container[transformed_key].call(input)

            if container[transformed_key].transproc_name == :add_context
              context_key = container[transformed_key].output_key
              @contexts[context_key] = {name: context_key, item: data.first[-1]}
              return
            end
          end

          if current_document
            current_document.append(data || input)
          else
            t(:build_nested_hash)[record, [], data || input]
          end
        end

        def record_unique_identifier(key)
          return nil if @wild_char_matchers.empty?
          key.match(/#{@wild_char_matchers.join('|')}/).to_a[0]
        end

        def match_wildcard_chars(key)
          return key if @wild_char_matchers.empty?
          key.gsub(/#{@wild_char_matchers.join('|')}/, '*')
        end

        def record_builder
          @record_queue.last
        end

        def t(*args)
          TransformFunctions[*args]
        end

        def error(message, line, column); end

        # def each(&block)
        #   until @buffer.include?(namespace_record_delimiter)
        #     @buffer << @io.sysread(BufferLength)
        #   end

        #   line, @buffer = @buffer.split(namespace_record_delimiter, 2)

        #   block.call(line)
        #   each(&block)
        # rescue EOFError
        #   @io.close
        # end
      end
    end
  end
end
