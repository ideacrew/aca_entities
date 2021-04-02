# rubocop:disable all
require 'oj'
require 'deep_merge'

module Operations
  class Transform < Oj::Saj
    BufferLength = 512

    attr_reader :source_filename, :namespaces, :namespace_record_delimiter, :array_namespaces, :container, :records, :record, :record_identifier, :record_index

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
    end

    def namespace_tranform_for(key)
      return unless defined? @record_delimiter_matched_namespace
      # key_with_namespace = (@namespaces - @record_delimiter_matched_namespace).push(key).join('.')
      # return if @namespace_mappings[key_with_namespace]

      # data = container[key].call(Hash[key_with_namespace.to_sym, nil]) if container.key?(key)
      # @namespace_mappings[key_with_namespace] = data&.keys&.first || key_with_namespace

      # return @mappings[key] if @mappings.key?(key)
      # return key unless container.key?(key)
      # @mappings[key] = container[key].process
      namespace_mappping_for(key, @namespaces)
    end


    def namespace_mappping_for(key, namespace_list)
      key_with_namespace = (namespace_list - @record_delimiter_matched_namespace).push(key).join('.')
      return @namespace_mappings[key_with_namespace] if @namespace_mappings[key_with_namespace]

      if container.key?(key_with_namespace)
        input = initialize_or_assign({}, namespace_mappings_set.compact.map(&:to_sym), Hash[key.to_sym, nil])
        data = container[key_with_namespace].call(input) 
      end
      # binding.pry if key && key.to_sym == :application

      @namespace_mappings[key_with_namespace] = nested_keys(data).map(&:to_s).join('.') || key_with_namespace
    end

    def nested_keys(data)
      return [] unless data
      data.reduce([]) do |keys, (key, value)|
        # if value && !value.empty?
          keys.push(key) 
          keys += nested_keys(value)
        # end
        
        keys
      end
    end

    # applications: {
    #   <id>: {
    #     result: {
    #       <id>: {
    #         record: {

    #         }
    #       }
    #     }
    #   }
    # }

    # 'applications.identifier.result.identifier.record'
    # {
    #   0: 'applications',
    #   2: 'result',
    #   4: 'record'
    # }

    # [nil,'applications', '42232', 'result', '626323', 'record']

    # ['applications', '42232', 'result', '626323', 'record']
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

    def record_start(key)
      @record_identifier = key

      first_delimiter_match_index = @namespaces.index(namespace_record_delimiter[0])
      max_delimier_index = non_identifier_delimiters.keys.last
      binding.pry
      @record_index = (first_delimiter_match_index + max_delimier_index) # (@namespaces.index(namespace_record_delimiter) + 1)
      @record = {}
      puts "***** record started for #{key}"
    end

    def record_end(key)
      @records.push(record)
      # new_record = record

      # @container.each do |key, mapper|
      #   new_record = mapper.call(new_record)
      # end
      binding.pry

      puts "***** record ended for #{key}"
    end

   # "attestations"=>
   #  {"application"=>
   #    {"comments"=>"Versioning For Change in Circumstance"}}

   #  {'attestations.application': {}}

   #  {'employee_attestations.application'}

    def hash_start(key)
      namespace_tranform_for(key)
      @namespaces.push(key&.to_sym)
      if namespace_record_delimiter_matched?(@namespaces)# if @namespaces.last == namespace_record_delimiter
        # unless defined? @record_delimiter_matched_namespace
          @record_delimiter_matched_namespace ||= @namespaces.dup
          # binding.pry
        # end
        record_start(key&.to_sym)
      end
      puts "---hash_start -- #{key}"
      puts "---hash_start_namespaces--#{namespaces}"
    end
    
    # [:applications, '42323', 'result', 'enrollees']
    # [:applications, '42323', 'result']
    def hash_end(key)
      # key = renamed_key_for(key)
      matched = namespace_record_delimiter_matched?(@namespaces)
      @namespaces.pop
      puts "---hash_end -- #{key}"
      puts "---hash_end_namespaces--#{namespaces}"
      record_end(key&.to_sym) if matched
    end

    def array_start(key)
      # key = renamed_key_for(key)
      @array_namespaces.push(key&.to_sym)
      @array_records = [] if key
      @array_record = []
      puts "---array_start -- #{key}"
      puts "---array_start_array_namespaces--#{array_namespaces}"
    end

    def array_end(key)
      # key = renamed_key_for(key)
      @array_namespaces.pop
      if key
        value = @array_records.empty? ? @array_record : @array_records

        input = Hash[key.to_sym, value]
        data = container[key].call(input) if container.key?(key)

        # transformed_namespaces = @namespaces[(record_index + 1)..-1].collect{|ns| @namespace_mappings[ns.to_s]}
        transformed_namespaces = namespace_mappings_set.compact.map(&:to_sym)

        initialize_or_assign(record, transformed_namespaces.compact.map(&:to_sym), data || input)
        # initialize_or_assign(record, @namespaces[(record_index + 1)..-1], key.to_sym, value)
      else
        @array_records.push(@array_record)
      end
      
      puts "---array_end -- #{key}"
      puts "---array_end_array_namespaces--#{array_namespaces}"
    end

    # ["familyRelationships", nil]
    # familyRelationships: [element, [element, element]]
    # familyRelationships: [element, {}]
    # familyRelationships: [element, element]
    # [["1435239665677772593","SELF","1435239665677772593"]]
    def add_value(value, key)
      # key = renamed_key_for(key)
      unless array_namespaces.empty?
        @array_record << if key
          Hash[key.to_sym, value]
        else
          value
        end
        return
      end

      return unless record_index

      if defined? @record_delimiter_matched_namespace
        key_with_namespace = (@namespaces - @record_delimiter_matched_namespace).push(key).join('.')
        key_transformed_namespaces = namespace_mappings_set.compact.map(&:to_sym)
      end

      key_for_transform = key_with_namespace || key
      # input = Hash[key_with_transformed_namespaces.to_sym, value]
      # binding.pry if key.to_sym == :sourceSystemName
      # binding.pry if key.to_sym == :comments
      # binding.pry if key.to_sym == :absentParentAgreementIndicator

      if container.key?(key_for_transform)
        input = initialize_or_assign({}, key_transformed_namespaces, Hash[key.to_sym, value])
        data = container[key_for_transform].call(input)
      else
        transformed_namespaces = namespace_mappings_set.compact.map(&:to_sym) #(@namespaces - @record_delimiter_matched_namespace).collect{|ns| @namespace_mappings[ns.to_s]}
        data = Hash[key.to_sym, value]
      end
  
      initialize_or_assign(record, transformed_namespaces || [], data || input)
      # initialize_or_assign(record, @namespaces[(record_index + 1)..-1], key.to_sym, value)

      puts "---add_value -- #{key} ---- #{value}"
    end


    def namespace_mappings_set
      element_namespaces = (@namespaces - @record_delimiter_matched_namespace)

      # array = [:computed, :application, :bestSEP]
      # [:computed, :application] + [:bestSEP]
      # [:computed] + [:application, :bestSEP]
      # if @namespaces.last.to_s == 'bestSEP'

      set = []
      array = element_namespaces

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

      # end
      # element_namespaces.each_with_index.collect do |ns, index|
      #   ns_prefixes = element_namespaces[0..index-1] if index != 0
      #   namespace_str = (ns_prefixes || []).push(ns).map(&:to_s).join('.')
      #   @namespace_mappings[namespace_str]&.to_s&.split('.')&.last || ns.to_s
      # end
    end

    def initialize_or_assign(local_record, values = [], data)
    # def initialize_or_assign(local_record, values = [], key, value)
      # if key.split('.').size > 1
      #   key_namespaces = key.split('.')
      #   key = key_namespaces.pop
      #   values += key_namespaces
      # end

      # if current_namespace = values.shift
      #   local_record[current_namespace] ||= {}

      #   if values.empty?
      #     local_record[current_namespace][key] = value
      #   else
      #     local_record[current_namespace] = initialize_or_assign(local_record[current_namespace], values, key, value)
      #   end
      # else
      #   local_record[key] = value
      # end

      # local_record

      if current_namespace = values.shift
        local_record[current_namespace] ||= {} 

        if values.empty?
          local_record[current_namespace].deep_merge!(data)
        else
          local_record[current_namespace] = initialize_or_assign(local_record[current_namespace], values, data)
        end
      else
        local_record.deep_merge!(data)
      end

      local_record
    end

    def error(message, line, column); end

    def call
      puts "----inside calll"
      File.open(@source_filename, 'r') { |f| Oj.saj_parse(self, f) }

      # close input and output files
      # return Monad around file processing, output file close result
    end

    private

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