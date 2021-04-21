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
            service.namespace_record_delimiter = namespace_record_delimiter || []
            service.call(&block)
          end

          def transform(payload)
            service = new
            service.namespace_record_delimiter = []
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
          find_or_build_namespace_mappping_for(key) if defined? @record_namespace_offset
          @namespaces.push(key&.to_sym)

          if namespace_record_delimiter_matched?(@namespaces) && @array_namespaces.empty?
            @record_namespace_offset ||= @namespaces.dup
            record_start(key&.to_sym)
          end

          @sub_records.push({}) if batch_process?

          add_new_elements(key) if defined? @record_namespace_offset
        end

        def hash_end(key)
          matched = namespace_record_delimiter_matched?(@namespaces) && @array_namespaces.empty?
          close_sub_record if record_builder && !record_builder.data_set.empty?

          @namespaces.pop
          @contexts.delete(key) unless batch_process?

          if batch_process?
            sub_record = @sub_records.pop

            if key
              if sub_record && current_sub_record
                t(:build_nested_hash)[current_sub_record, [], Hash[key.to_sym, sub_record]]
              elsif sub_record && current_sub_record.nil?
                t(:build_nested_hash)[record, element_namespaces, Hash[key.to_sym, sub_record]]
              end
            elsif current_sub_record
              if current_sub_record.is_a?(Array)
                current_sub_record.push(sub_record)
              else
                current_sub_record.deep_merge!(sub_record) unless current_sub_record.is_a?(Array)
              end
            else
              record.deep_merge!(sub_record)
            end
          end

          record_end(key&.to_sym) if matched
        end

        def array_start(key)
          @array_namespaces.push(key&.to_sym)
          @array_records = [] if key
          @array_record = []
          @sub_records.push([]) if batch_process?
        end

        def array_end(key)
          @array_namespaces.pop
          sub_record = @sub_records.pop if batch_process?

          if key
            value = @array_records.empty? ? @array_record : @array_records
            if batch_process?
              unless sub_record.is_a?(Array)
                if current_sub_record
                  t(:build_nested_hash)[current_sub_record, [], Hash[key.to_sym, value]]
                else
                  transform_data_for(key, value)
                end
              else
                if current_sub_record
                  # if current_sub_record.is_a?(Array)
                  #   current_sub_record.push(sub_record)
                  # else
                    current_sub_record.deep_merge!(Hash[key.to_sym, sub_record]) unless current_sub_record.is_a?(Array)
                  # end
                else
                  transform_data_for(key, sub_record)
                end
              end
            else
              transform_data_for(key, value)
            end
          else
            @array_records.push(@array_record)
          end
        end

        def add_value(value, key)
          unless array_namespaces.empty?
            if current_sub_record && key && batch_process?
              t(:build_nested_hash)[current_sub_record, [], Hash[key.to_sym, value]]
            else
              @array_record << (key.nil? ? value : Hash[key.to_sym, value])
            end
            return
          end

          return unless record_index
          transform_data_for(key, value)
        end

        private

        def element_namespaces
          namespaces - @record_namespace_offset
        end

        def add_new_elements(key)
          return if batch_process?
          namespaced_key = element_namespaces.join('.')
          namespaced_key = match_wildcard_chars(namespaced_key)
          process_add_namespaces(namespaced_key, key)
        end

        def process_add_namespaces(namespaced_key, key, root = true)
          initialize_sub_record(namespaced_key, key) unless root

          if namespaced_key == ''
            build_add_namespace('add_key', key)
          else
            build_add_namespace(namespaced_key, key)
          end

          close_sub_record(false) unless root
        end

        def build_add_namespace(namespaced_key, key)
          container.keys_under_namespace(namespaced_key).each do |key_under_ns|
            if container[key_under_ns].transproc_name == :add_namespace
              process_add_namespaces(key_under_ns, key, false)
            end

            if container[key_under_ns].transproc_name == :add_key
              input = {source_hash: Hash[key_under_ns.split('.').last.to_sym, nil]}
              input.merge!(context: Context.new(@contexts)) unless @contexts.empty?
              data = container[key_under_ns].call(input)[:source_hash]
              if record_builder
                record_builder.append(record_builder.namespace, data)
              else
                t(:build_nested_hash)[record, [], data]
              end
            end
          end
        end

        def initialize_sub_record(container_key, key)
          builder = RecordBuilder.new(root: container_key, type: container[container_key].type)
          builder.output_namespace = container[container_key].output_key
          builder.parent_namespace = @record_queue.last&.output_ns
          builder.namespace = key
          @record_queue.push(builder)
        end

        def close_sub_record(validate_namespace = true)
          return if batch_process?
          record_builder = @record_queue.last
          return if validate_namespace && record_builder.root.split('.').size != element_namespaces.size

          @wild_char_matchers.delete(@record_queue.last.namespace)
          @record_queue.pop

          if @record_queue.empty?
            t(:build_nested_hash)[record, [], record_builder.output]
          else
            @record_queue.last.append(@record_queue.last.namespace, record_builder.output, false)
          end

          record_builder = nil
        end

        def find_or_build_namespace_mappping_for(key)
          return unless defined? @record_namespace_offset

          key_with_namespace = (element_namespaces + [key]).join('.')
          regex_key = (element_namespaces + ['*']).join('.') unless element_namespaces.compact.empty?

          initialize_new_record_for(regex_key, key) if regex_key
          initialize_new_record_for(key_with_namespace, key)

          return @namespace_mappings[key_with_namespace] if @namespace_mappings.key?(key_with_namespace)
          return unless container.key?(key_with_namespace)

          build_namespace_mapping_for(element_namespaces, key)
        end

        def initialize_new_record_for(namespaced_key, key)
          namespaced_key = match_wildcard_chars(namespaced_key)

          if container.key?(namespaced_key) && (record_builder.nil? || record_builder.root != namespaced_key)
            container_value = container[namespaced_key]
            @contexts[key] = container_value.context.merge(item: key) if container_value.context

            if container_value.type == :array
              initialize_sub_record(namespaced_key, key)
              @wild_char_matchers.push(key) if namespaced_key.split('.').last == '*'
            end
          end
        end

        def build_namespace_mapping_for(element_namespaces, key, value = nil)
          key_with_namespace = (element_namespaces + [key]).join('.')
          input = t(:build_nested_hash)[{}, element_namespaces, Hash[key.to_sym, value]]
          data = container[key_with_namespace].call(input)

          @namespace_mappings[key_with_namespace] = (t(:nested_hash_to_array)[data]).join('.')
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
            t(:build_nested_hash)[record, element_namespaces, Hash[key.to_sym, value]] 
            return
          end

          key_with_namespace = (element_namespaces + [key]).join('.')
          transformed_key = match_wildcard_chars(key_with_namespace.dup)
          record_unique_identifier = record_unique_identifier(key_with_namespace)

          return unless container.key?(transformed_key)

          input = if record_unique_identifier
                    t(:build_nested_hash)[{}, [], Hash[key.to_sym, value]]
                  else
                    t(:build_nested_hash)[{}, element_namespaces, Hash[key.to_sym, value]]
                  end

          data = container[transformed_key].call(input)
          if container[transformed_key].transproc_name == :add_context
            context_key = container[transformed_key].output_key
            @contexts[context_key] = {name: context_key, item: data.first[-1]}
            return
          end

          if record_unique_identifier
            record_builder.append(record_builder.namespace, data || input)
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
