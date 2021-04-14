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

        attr_reader :source_filename, :namespaces, :namespace_record_delimiter, :array_namespaces, :container, :records, :record, :record_index

        class << self
          def call(*args)
            service = new(*args)
            service.call
          end

          def namespace_record_delimiter
            @namespace_record_delimiter || '$/'
          end

          def record_delimiter(delimiter)
            @namespace_record_delimiter = delimiter
          end
        end

        def initialize(source_filename, output_filename, options = {})
          @source_filename = source_filename
          @namespace_record_delimiter = self.class.namespace_record_delimiter.split('.').map(&:to_sym)
          @namespaces = []
          @array_namespaces = []
          @records = []
          @container = self.class.mapping_container
          @namespace_mappings = Hash.new
          @record_queue = []
          @wild_char_matchers = []
          @contexts = {}
        end

        def call
          File.open(@source_filename, 'r') { |f| Oj.saj_parse(self, f) }
          # close input and output files
          # return Monad around file processing, output file close result
        end

        def t(*args)
          ::Transform::TransformFunctions[*args]
        end

        def record_start(key)
          first_delimiter_match_index = @namespaces.index(namespace_record_delimiter[0])
          max_delimier_index = non_identifier_delimiters.keys.last
          @record_index = (first_delimiter_match_index + max_delimier_index) # (@namespaces.index(namespace_record_delimiter) + 1)
          @record = {}
          puts "***** record started for #{key}"
        end

        def record_end(key)
          @records.push(record)
          remove_instance_variable(:@record_namespace_offset)
          binding.pry

          puts "***** record ended for #{key}"
        end

        def hash_start(key)
          find_or_build_namespace_mappping_for(key) if defined? @record_namespace_offset

          @namespaces.push(key&.to_sym)
          if namespace_record_delimiter_matched?(@namespaces)
            @record_namespace_offset ||= @namespaces.dup
            record_start(key&.to_sym)
          end

          add_new_elements(key) if defined? @record_namespace_offset

          puts "---hash_start -- #{key}"
          puts "---hash_start_namespaces--#{namespaces}"
        end

        def hash_end(key)
          matched = namespace_record_delimiter_matched?(@namespaces)
          close_sub_record if record_builder && !record_builder.data_set.empty?

          @namespaces.pop
          @contexts.delete(key)

          puts "---hash_end -- #{key}"
          puts "---hash_end_namespaces--#{namespaces}"
          record_end(key&.to_sym) if matched
        end

        def array_start(key)
          @array_namespaces.push(key&.to_sym)
          @array_records = [] if key
          @array_record = []
          puts "---array_start -- #{key}"
          puts "---array_start_array_namespaces--#{array_namespaces}"
        end

        def array_end(key)
          @array_namespaces.pop

          if key
            value = @array_records.empty? ? @array_record : @array_records
            transform_data_for(key, value)
          else
            @array_records.push(@array_record)
          end

          puts "---array_end -- #{key}"
          puts "---array_end_array_namespaces--#{array_namespaces}"
        end

        def add_value(value, key)
          puts "---add_value -- #{key} ---- #{value}"

          unless array_namespaces.empty?
            @array_record << (key.nil? ? value : Hash[key.to_sym, value])
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
          namespaced_key = element_namespaces.join('.')
          @wild_char_matchers.each {|char| namespaced_key.gsub!(/#{char}/, '*')}
          process_add_namespaces(namespaced_key, key)
        end

        def process_add_namespaces(namespaced_key, key, root = true)
          initialize_sub_record(namespaced_key, key) unless root

          container.keys_under_namespace(namespaced_key).each do |key_under_ns|
            if container[key_under_ns].transproc_name == :add_namespace
              process_add_namespaces(key_under_ns, key, false)
            end

            if container[key_under_ns].transproc_name == :add_key
              input = {source_hash: Hash[key_under_ns.split('.').last.to_sym, nil]}
              input.merge!(context: Context.new(@contexts)) unless @contexts.empty?
              data  = container[key_under_ns].call(input)[:source_hash]
              if record_builder
                record_builder.append(record_builder.namespace, data)
              else
                t(:build_nested_hash)[record, [], data]
              end
            end
          end
          close_sub_record(false) unless root
        end

        def initialize_sub_record(container_key, key)
          builder = RecordBuilder.new(root: container_key, type: container[container_key].type)
          builder.output_namespace = container[container_key].output_key
          builder.parent_namespace = @record_queue.last&.output_ns
          builder.namespace = key
          @record_queue.push(builder)
        end

        def close_sub_record(validate_namespace = true)
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
          initialize_new_record_for(key_with_namespace.dup, key)

          return @namespace_mappings[key_with_namespace] if @namespace_mappings.key?(key_with_namespace)
          return unless container.key?(key_with_namespace)

          build_namespace_mapping_for(element_namespaces, key)
        end

        def initialize_new_record_for(namespaced_key, key)
          @wild_char_matchers.each {|char| namespaced_key.gsub!(/#{char}/, '*') }

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
          input = t(:build_nested_hash)[{}, element_namespaces.dup, Hash[key.to_sym, value]]
          data = container[key_with_namespace].call(input)

          @namespace_mappings[key_with_namespace] = (t(:nested_hash_to_array)[data]).join('.')
        end

        def namespace_record_delimiter_matched?(namespaces)
          return false if namespaces.empty?
          return false unless namespaces.index(namespace_record_delimiter[0])

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

        def transform_data_for(key, value)
          return unless defined? @record_namespace_offset

          key_with_namespace = (element_namespaces + [key]).join('.')
          transformed_key = transform_to_wildcard(key_with_namespace.dup)
          record_unique_identifier = record_unique_identifier(key_with_namespace)

          return unless container.key?(transformed_key)

          input = if record_unique_identifier
            t(:build_nested_hash)[{}, [], Hash[key.to_sym, value]]
          else
            t(:build_nested_hash)[{}, element_namespaces.dup, Hash[key.to_sym, value]]
          end

          namespace_transform_needed = true
          data = container[transformed_key].call(input)
          if container[transformed_key].transproc_name == :add_context
            context_key = container[transformed_key].output_key
            @contexts[context_key] = {name: context_key, item: data.first[-1]}
            return
          end

          namespace_transform_needed = container[transformed_key].namespace_transform_required?
          data_hash = transform_hash(data || input) if namespace_transform_needed

          if record_unique_identifier
            record_builder.append(record_builder.namespace, data_hash || data)
          else
            t(:build_nested_hash)[record, [], data_hash || data]
          end
        end

        def record_unique_identifier(key)
          return nil if @wild_char_matchers.empty?
          key.match(/#{@wild_char_matchers.join('|')}/).to_a[0]
        end

        def transform_to_wildcard(key)
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

# # This how we call the operation
# result =
#   Medicaid::Transforms::IapTo::MitcInput.call(source_filename, output_filename)
# result =
#   Medicaid::Transforms::MitcResultTo::Iap.call(source_filename, output_filename)
