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

        attr_reader :namespaces, :namespace_record_delimiter, :array_namespaces, :container, :record

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
          @wild_char_matchers = []
          @contexts = {}
          @transform_mode = options[:transform_mode]&.to_sym || :single
          @namespaces_with_types = []
          @documents = []
        end

        def current_document
          @documents.last
        end

        def namespace_record_delimiter=(delimiter)
          @namespace_record_delimiter = delimiter
        end

        def call(&block)
          @record_processor = block

          if json_input?(@source)
            Oj.saj_parse(self, @source)
          else
            File.open(@source, 'r') {|f| Oj.saj_parse(self, f)}
          end
        end

        def record_start(key)
          @record = {}
        end

        def record_end(key)
          @record_processor.call(record) if @record_processor
          @contexts = {}
          remove_instance_variable(:@record_namespace_offset)
        end

        def hash_start(key)
          key = :no_key unless key
          find_or_build_namespace_mappping_for(key) if defined? @record_namespace_offset

          @namespaces.push(key.to_sym)
          @namespaces_with_types.push(Hash[key.to_sym, :hash])

          if namespace_record_delimiter_matched?(@namespaces) && @array_namespaces.empty?
            @record_namespace_offset ||= @namespaces.dup
            record_start(key&.to_sym)
          end

          construct_document_with(key, :hash) if defined? @record_namespace_offset
          # add_new_elements(key) if defined? @record_namespace_offset
        end

        def hash_end(key)
          add_new_elements(key) if defined? @record_namespace_offset
          key = :no_key unless key

          matched = namespace_record_delimiter_matched?(@namespaces) && @array_namespaces.empty?
          @namespaces.pop
          @contexts.delete(key) unless batch_process?

          merge_documents(key, :hash)
          @namespaces_with_types.pop

          record_end(key&.to_sym) if matched
        end

        def array_start(key)
          key = :no_key unless key
          @array_namespaces.push(key&.to_sym)
          @namespaces_with_types.push(Hash[key.to_sym, :array])
          construct_document_with(key, :array) if defined? @record_namespace_offset
          @array_record = []
        end

        def array_end(key)
          @array_namespaces.pop
          @namespaces_with_types.pop

          if key
            value = @array_record
            if !batch_process? && !value.empty?
              transform_data_for(key, value)
              @array_record = []
            end
          end

          merge_documents(key, :array)
        end

        def add_value(value, key)
          @array_record << value unless key
          transform_data_for(key, value)
        end

        private

        def json_input?(source)
          begin
            JSON.parse(source)
          rescue
            false
          end
        end

        def construct_document_with(key, type)
          if batch_process? || key == :no_key
            add_document(key: key, type: type)
          else
            transformed_key = match_wildcard_chars(element_namespaces.join('.'))
            if container.key?(transformed_key)
              create_document_for(transformed_key, key, type, false)
            elsif container.key?(transformed_key+'_context')
              add_document(key: key, type: type)
            end
          end
        end

        def add_document(key:, type:, source_namespace: nil, output_namespace: nil, regex: nil)
          document = if type == :hash
            AcaEntities::Operations::Transforms::HashDocument.new(key)
          elsif type == :array
            AcaEntities::Operations::Transforms::ArrayDocument.new(key)
          end

          document.source_namespace = source_namespace || element_namespaces
          document.output_namespace = output_namespace || element_namespaces
          document.parent_namespace = @documents.last&.output_namespace
          @documents.push(document)
        end

        def create_document_for(namespaced_key, key, type, regex = false)
          @wild_char_matchers.push(key) if regex
          mapping = container[namespaced_key]
          mapping_type = mapping.type || type

          source_key = mapping.source_key 
          output_key = mapping.output_key

          regex_key = key if regex
          add_document(key: key, type: mapping_type, source_namespace: source_key, output_namespace: output_key&.split('.'), regex: regex_key)

          if mapping.type == :array && type == :hash
            add_document(key: :no_key, type: type, regex: regex_key)
          end
        end

        def merge_documents(key, type)
          return if @documents.empty?
          return if type == :array && current_document&.is_a?(AcaEntities::Operations::Transforms::HashDocument)

          unless batch_process?
            if type == :hash && key != :no_key
              transformed_key = match_wildcard_chars(element_namespaces.join('.'))
              context_key = transformed_key + "_context"
              record_context = container.key?(context_key) && container[context_key].memoize_record
              return unless container.key?(transformed_key) || record_context
            end
          end

          recent_document = @documents.pop

          if record_context
            output_key = container[context_key].output_key
            @contexts[output_key] = {name: output_key, item: recent_document.output&.values&.first}
          else
            if current_document
              current_document.merge(recent_document.output)
            elsif recent_document
              record.deep_merge!(recent_document.output)
            end
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
          if namespace_add
            add_document(key: :no_key, type: :hash, output_namespace: namespaced_key)
            current_document.parent_namespace = nil
          end
     
          if namespaced_key == ''
            build_add_namespace('add_key', key)
          else
            build_add_namespace(namespaced_key, key)
          end

          merge_documents(key, :hash) if namespace_add
        end

        def build_add_namespace(namespaced_key, key)
          container.keys_under_namespace(namespaced_key).each do |key_under_ns|
            if container[key_under_ns].transproc_name.to_s == 'add_namespace'
              process_add_namespaces(key_under_ns, key, true)
            end

            if container[key_under_ns].transproc_name.to_s == 'add_key'
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

          if container.key?(namespaced_key)
            container_value = container[namespaced_key]
            @contexts[key] = container_value.context.merge(item: key) if container_value.context

            if container_value.type == :array
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

        def record_context_matched?
          key_with_namespace = element_namespaces.join('.')
          transformed_key = match_wildcard_chars(key_with_namespace.dup)
          transformed_key += '_context'
          container.key?(transformed_key) && container[transformed_key].memoize_record
        end

        def transform_data_for(key, value)
          return unless defined? @record_namespace_offset
      
          if batch_process?
            input = t(:build_nested_hash)[{}, [], Hash[key.to_sym, value]] if key
            input ||= value
          else
            key_with_namespace = (element_namespaces + [key]).join('.')
            transformed_key = match_wildcard_chars(key_with_namespace.dup)
            record_unique_identifier = record_unique_identifier(key_with_namespace)

            if container.key?(transformed_key + '_context')
              context_key = container[transformed_key + '_context'].output_key
              @contexts[context_key] = {name: context_key, item: value}
            end

            return unless container.key?(transformed_key) || record_context_matched?
            # container_value = container[transformed_key]
            # @contexts[key] = container_value.context.merge(item: value) if container_value.context
            input = if record_unique_identifier
                      t(:build_nested_hash)[{}, [], Hash[key.to_sym, value]]
                    else
                      t(:build_nested_hash)[{}, element_namespaces_with_types, Hash[key.to_sym, value]]
                    end

            if container.key?(transformed_key)
              data = container[transformed_key].call(input)
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
