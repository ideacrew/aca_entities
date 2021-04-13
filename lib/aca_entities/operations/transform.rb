# rubocop:disable all
require 'oj'
require 'deep_merge'

module Operations


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
      binding.pry
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

      if record_builder && !record_builder.data_set.empty?
        close_recent_record(key)
      end

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
        @array_record << if key
          Hash[key.to_sym, value]
        else
          value
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
      namespaced_key = element_namespaces.join('.')
      @wild_char_matchers.each {|char| namespaced_key.gsub!(/#{char}/, '*')}

      keys_under_namespace = container.keys_under_namespace(namespaced_key)
      namespace_keys = keys_under_namespace.select{|key| container[key].transproc_name == :add_namespace}
      execute_add_namespaces(namespace_keys, namespaced_key, key)

      namespace_keys.each do |namespace_key|
        keys_under_namespace.each_with_index do |key, index|
          keys_under_namespace.delete_at(index) if key.match?(/^#{Regexp.escape(namespace_key)}.*/)
        end
      end

      keys_under_namespace.each do |container_key|
        next if container[container_key].transproc_name == :add_context
        next unless container[container_key].transproc_name == :add_key

        # if container[container_key].transproc_name == :add_key
          input = {source_hash: Hash[container_key.split('.').last.to_sym, nil]}
          input.merge!(context: Operations::Context.new(@contexts)) unless @contexts.empty?
          data  = container[container_key].call(input)[:source_hash]
        # else
        #   input = Hash[container_key.split('.').last.to_sym, nil]
        #   data  = container[container_key].call(input)
        # end

        # data  = container[container_key].call()
        # binding.pry if key.to_s == 'demographic'
        if record_builder # && container_key.match(/^#{Regexp.escape(record_builder.root)}\.\w+$/)
          record_builder.append(record_builder.namespace, data)
        else
          initialize_or_assign(record, [], data)
        end
      rescue
        binding.pry
      end
    end

    def execute_add_namespaces(namespace_keys, namespaced_key, key)
      namespace_keys.each do |namespace_key|
        create_record(namespace_key, namespaced_key, key)
        container.keys_under_namespace(namespace_key).each do |key|
          if container[key].transproc_name == :add_namespace
            execute_add_namespaces([key], namespace_key, key)
          end

          if container[key].transproc_name == :add_key
            input = {context: Operations::Context.new(@contexts), source_hash: Hash[key.split('.').last.to_sym, nil]}

            # input = {context: @contexts, source_hash: Hash[key.split('.').last.to_sym, nil]}
            data  = container[key].call(input)[:source_hash]
            record_builder.append(record_builder.namespace, data)
          end
        end
        close_recent_record(key, false)
      end
    end

    def create_record(container_key, namespaced_key, key)
      builder = ::AcaEntities::Operations::RecordBuilder.new(root: namespaced_key, type: container[container_key].type)
      builder.output_namespace = container[container_key].output_key
      builder.parent_namespace = @record_queue.last&.output_ns
      builder.namespace = key
      @record_queue.push(builder)
    end

    def close_recent_record(key, validate_namespace = true)
      record_builder = @record_queue.last
      return if validate_namespace && record_builder.root.split('.').size != element_namespaces.size

      @wild_char_matchers.delete(@record_queue.last.namespace)
      @record_queue.pop

      if @record_queue.empty?
        initialize_or_assign(record, [], record_builder.output)
      else
        @record_queue.last.append(@record_queue.last.namespace, record_builder.output, false)
      end

      record_builder = nil
    end

    # Inject given arguments into the constructor of the class
    #
    # @example
    #   Transproct(:constructor_inject, Struct)['User', :name, :age]
    #   # => Struct::User
    #
    # @param [*Mixed] A list of arguments to inject
    #
    # @return [Object] An instance of the given klass
    #
    # @api private
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
        # binding.pry if namespaced_key.to_s == "attestations.members.*"

        container_value = container[namespaced_key]
        @contexts[key] = container_value.context.merge(item: key) if container_value.context
        # if container_value.context
        #   @hash_key_context_mappings[key] = container_value.context[:name]
        #   @contexts.register(container_value.context[:name], OpenStruct.new(container_value.context.merge(key: key)))
        # end

        if container_value.type == :array
          create_record(namespaced_key, namespaced_key, key)
          @wild_char_matchers.push(key) if namespaced_key.split('.').last == '*'
        end
      end
    end

    def build_namespace_mapping_for(element_namespaces, key, value = nil)
      key_with_namespace = (element_namespaces + [key]).join('.')

      input = initialize_or_assign({}, element_namespaces.dup, Hash[key.to_sym, value])
      data = container[key_with_namespace].call(input)

      # FiX ME: Can be deleted?
      # transformed_namespaces = namespace_mappings_for(new_namespaces[0..-2]) + [new_namespaces.last.to_s]
      # @namespace_mappings[key_with_namespace] = transformed_namespaces.join('.')

      @namespace_mappings[key_with_namespace] = namespace_hash_to_array(data).join('.')
    end

    def namespace_hash_to_array(data)
      return [] unless data
      data.reduce([]) do |keys, (key, value)|
        keys.push(key) 
        keys.concat(namespace_hash_to_array(value))
      end
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

      return unless container.key?(transformed_key) #|| container.key?(element_namespaces.join('.'))

      input = if record_unique_identifier
        initialize_or_assign({}, [], Hash[key.to_sym, value])
      else
        initialize_or_assign({}, element_namespaces.dup, Hash[key.to_sym, value])
      end

      namespace_transform_needed = true
      data = container[transformed_key].call(input) 
      if container[transformed_key].transproc_name == :add_context
        context_key = container[transformed_key].output_key
        @contexts[context_key] = {name: context_key, item: data.first[-1]}
        return
      end
      namespace_transform_needed = container[transformed_key].namespace_transform_required?

      # binding.pry if key.to_s == 'sex'

      data_hash = transform_hash(data || input) if namespace_transform_needed

      if record_unique_identifier
        record_builder.append(record_builder.namespace, data_hash || data)
      else
        initialize_or_assign(record, [], data_hash || data)
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

    # def transform_hash(data_hash)
    #   data_pair = data_hash.dig(*element_namespaces) unless element_namespaces.empty?
    #   initialize_or_assign({}, namespace_mappings_for(element_namespaces).map(&:to_sym), data_pair || data_hash)
    # rescue
    #   binding.pry
    # end

    # def namespace_mappings_for(element_namespaces)
    #
    #   set = []
    #   element_namespaces.size.times do |i|
    #     sample = element_namespaces[0..(element_namespaces.size - (1 + i))]
    #     namespace_str = sample.map(&:to_s).join('.')

    #     if @namespace_mappings.key?(namespace_str)
    #       set = @namespace_mappings[namespace_str].split('.') + (element_namespaces - sample).map(&:to_s)
    #       break
    #     else
    #       next
    #     end
    #   end

    #   return set unless set.empty?
    #   element_namespaces.map(&:to_s)
    # end

    def initialize_or_assign(local_record, values = [], data)
      if current_namespace = values.shift
        local_record[current_namespace] ||= {} 

        if values.empty?
          if data.is_a?(Hash)
            local_record[current_namespace].deep_merge!(data)
          else
            local_record[current_namespace] = data
          end
        else
          local_record[current_namespace] = initialize_or_assign(local_record[current_namespace], values, data)
        end
      else
        local_record.deep_merge!(data)
      end

      local_record
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

# # This how we call the operation
# result =
#   Medicaid::Transforms::IapTo::MitcInput.call(source_filename, output_filename)
# result =
#   Medicaid::Transforms::MitcResultTo::Iap.call(source_filename, output_filename)