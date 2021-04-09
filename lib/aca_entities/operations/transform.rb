# rubocop:disable all
require 'oj'
require 'deep_merge'

module Operations

  class Transform < Oj::Saj

    BufferLength = 512

    attr_reader :source_filename, :namespaces, :namespace_record_delimiter, :array_namespaces, :container, :records, :record, :record_index

    # set_key_transform :camel # "some_key" => "SomeKey"
    # set_key_transform :camel_lower # "some_key" => "someKey"

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
      # file_descriptor = IO.sysopen(@source_filename)
      # @io = IO.new(file_descriptor)
      @namespace_record_delimiter = self.class.namespace_record_delimiter.split('.').map(&:to_sym)
      @namespaces = []
      @array_namespaces = []
      @records = []
      @container = self.class.mapping_container
      @namespace_mappings = Hash.new
      @record_pipe = []
      @record_namespaces = []
      @wild_char_matchers = []
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
      remove_instance_variable(:@record_delimiter_matched_namespace)
      binding.pry
      puts "***** record ended for #{key}"
    end

    def hash_start(key)
      find_or_build_namespace_mappping_for(key) if defined? @record_delimiter_matched_namespace
      @namespaces.push(key&.to_sym)
      
      if namespace_record_delimiter_matched?(@namespaces)
        @record_delimiter_matched_namespace ||= @namespaces.dup
        record_start(key&.to_sym)
      end

      process_append_transforms(namespaces, key) if defined? @record_delimiter_matched_namespace

      puts "---hash_start -- #{key}"
      puts "---hash_start_namespaces--#{namespaces}"
    end

    def hash_end(key)
      matched = namespace_record_delimiter_matched?(@namespaces)

      if record_builder && !record_builder.data_set.empty?
        write_records(key)
      end

      @namespaces.pop
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

    def process_append_transforms(namespaces, key)
      element_namespaces = (namespaces - @record_delimiter_matched_namespace)

      container.keys.each do |container_key|
        next if container[container_key].transproc.is_a? Dry::Transformer::Composite
        next unless container[container_key].transproc.name == :add_key

        if container_key.match(/^#{element_namespaces.join('.')}\.\w+$/)          
          data  = container[container_key].call(Hash[container_key.split('.').last.to_sym, nil])
          initialize_or_assign(record, [], data)
        elsif record_builder && container_key.match(/^#{record_builder.root}\.\w+$/)
          buider_root_ns = record_builder.root.split('.').map(&:to_sym)
          next unless buider_root_ns.size == element_namespaces.size && buider_root_ns[0..-2] == element_namespaces[0..-2]
          data  = container[container_key].call(Hash[container_key.split('.').last.to_sym, nil])
          record_builder.append(key, data)
        end
      end
    end

    def write_records(key)
      record_builder = @record_pipe.last

      element_namespaces = (namespaces - @record_delimiter_matched_namespace)
      return unless record_builder.root.split('.').size == element_namespaces.size

      @record_pipe.pop
      @wild_char_matchers.delete(@record_namespaces.pop)

      if @record_pipe.empty?
        initialize_or_assign(record, [], record_builder.output)
      else
        @record_pipe.last.append(@record_namespaces.last, record_builder.output, false)
      end

      record_builder = nil
    end

    def find_or_build_namespace_mappping_for(key)
      return unless defined? @record_delimiter_matched_namespace

      element_namespaces = (namespaces - @record_delimiter_matched_namespace)
      key_with_namespace = (element_namespaces + [key]).join('.')

      regex_key = (element_namespaces + ['*']).join('.') unless element_namespaces.compact.empty?

      # binding.pry if key.to_s == 'mailingAddress'
      
      verify_and_intialize_accumlator(regex_key, key) if regex_key
      verify_and_intialize_accumlator(key_with_namespace.dup, key)

      return @namespace_mappings[key_with_namespace] if @namespace_mappings.key?(key_with_namespace)
      return unless container.key?(key_with_namespace)

      build_namespace_mapping_for(element_namespaces, key)
    end

    def verify_and_intialize_accumlator(namespaced_key, key)
      @wild_char_matchers.each {|char| namespaced_key.gsub!(/#{char}/, '*') }

      if container.key?(namespaced_key) && (record_builder.nil? || record_builder.root != namespaced_key)

        if container[namespaced_key].type == :array
          builder = ::AcaEntities::Operations::RecordBuilder.new(root: namespaced_key, type: container[namespaced_key].type)
          builder.output_namespace = container[namespaced_key].output_key
          builder.parent_namespace = @record_pipe.last.output_ns unless @record_pipe.empty?
          record_unique_identifier = key
    
          @record_pipe.push(builder)
          @record_namespaces.push(key)
          @wild_char_matchers.push(key) if namespaced_key.split('.').last == '*'
        end
      end
    end

    def build_namespace_mapping_for(element_namespaces, key, value = nil)
      key_with_namespace = (element_namespaces + [key]).join('.')

      input = initialize_or_assign({}, element_namespaces.dup, Hash[key.to_sym, value])
      data = container[key_with_namespace].call(input)

      new_namespaces = namespace_hash_to_array(data)
      transformed_namespaces = namespace_mappings_for(new_namespaces[0..-2]) + [new_namespaces.last.to_s]

      @namespace_mappings[key_with_namespace] = transformed_namespaces.join('.') || key_with_transform
    end

    def namespace_hash_to_array(data)
      return [] unless data
      data.reduce([]) do |keys, (key, value)|
        keys.push(key) 
        keys += namespace_hash_to_array(value)        
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
      return unless defined? @record_delimiter_matched_namespace

      element_namespaces = (namespaces - @record_delimiter_matched_namespace)
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
      namespace_transform_needed = container[transformed_key].namespace_transform_required?

      data_hash = transform_hash(data || input, element_namespaces.dup) if namespace_transform_needed

      if record_unique_identifier
        record_builder.append(@record_namespaces.last, data_hash || data)
        # binding.pry if key.to_s == 'streetName1' || key == 'cityName'
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
      @record_pipe.last
    end

    def transform_hash(data_hash, namespace_set)
      data_pair = data_hash.dig(*namespace_set) unless namespace_set.empty?
      initialize_or_assign({}, namespace_mappings_for(namespace_set).map(&:to_sym), data_pair || data_hash)
    rescue
      binding.pry
    end

    def namespace_mappings_for(namespace_set = nil)
      element_namespaces = (namespace_set - @record_delimiter_matched_namespace)
      set = []
      element_namespaces.size.times do |i|
        sample = element_namespaces[0..(element_namespaces.size - (1 + i))]
        namespace_str = sample.map(&:to_s).join('.')

        if @namespace_mappings.key?(namespace_str)
          set = @namespace_mappings[namespace_str].split('.') + (element_namespaces - sample).map(&:to_s)
          break
        else
          next
        end
      end

      return set unless set.empty?
      element_namespaces.map(&:to_s)
    end

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