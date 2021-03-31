require 'oj'

module Operations
  class Transform < Oj::Saj
    BufferLength = 512

    attr_reader :source_filename, :namespace_record_delimiter, :namespaces, :array_namespaces, :records, :record, :record_identifier, :record_index

    # set_key_transform :camel # "some_key" => "SomeKey"
    # set_key_transform :camel_lower # "some_key" => "someKey"

    def self.call(*args)
      service = new(*args)
      service.call
    end

    def initialize(source_filename, output_filename, options = {})
      @source_filename = source_filename
      # file_descriptor = IO.sysopen(@source_filename)
      # @io = IO.new(file_descriptor)
      @namespace_record_delimiter =
        options.dig(:namespace_record_delimiter) || '$/'
      @namespaces = []
      @array_namespaces = []
      @records = []
    end

    def record_start(key)
      @record_identifier = key
      @record_index = (@namespaces.index(namespace_record_delimiter) + 1)
      @record = {}
      puts "***** record started for #{key}"
    end

    def record_end(key)
      @records.push(record)
      binding.pry
      puts "***** record ended for #{key}"
    end

    def hash_start(key)
      record_start(key) if @namespaces.last == namespace_record_delimiter
      @namespaces.push(key)
      puts "---hash_start -- #{key}"
      puts "---hash_start_namespaces--#{namespaces}"
    end
    
    def hash_end(key)
      @namespaces.pop
      puts "---hash_end -- #{key}"
      puts "---hash_end_namespaces--#{namespaces}"
      record_end(key) if @namespaces.last == namespace_record_delimiter
    end

    def array_start(key)
      @array_namespaces.push(key)
      @array_records = [] if key
      @array_record = []
      puts "---array_start -- #{key}"
      puts "---array_start_array_namespaces--#{array_namespaces}"
    end

    def array_end(key)
      @array_namespaces.pop
      if key
        value = @array_records.empty? ? @array_record : @array_records
        initialize_or_assign(record, @namespaces[(record_index + 1)..-1], key, value)
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
      unless array_namespaces.empty?
        @array_record << if key
          Hash[key, value]
        else
          value
        end
        return
      end

      # record[key] = value if @namespaces.last == @record_identifier
      initialize_or_assign(record, @namespaces[(record_index + 1)..-1], key, value)

      puts "---add_value -- #{key} ---- #{value}"
    end

    def initialize_or_assign(local_record, values, key, value)
      if current_namespace = values.shift
        local_record[current_namespace] ||= {} 

        if values.empty?
          local_record[current_namespace][key] = value
        else
          local_record[current_namespace] = initialize_or_assign(local_record[current_namespace], values, key, value)
        end
      else
        local_record[key] = value
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
