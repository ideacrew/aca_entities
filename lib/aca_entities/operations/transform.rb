# rubocop:disable all
require 'oj'

module Operations
  class Transform < Oj::Saj
    BufferLength = 512

    # set_key_transform :camel # "some_key" => "SomeKey"
    # set_key_transform :camel_lower # "some_key" => "someKey"

    def self.call(*args)
      new(*args)
      call
    end

    def initialize(source_filename, output_filename, options = {})
      @source_filename = source_filename
      file_descriptor = IO.sysopen(@source_filename)
      @io = IO.new(file_descriptor)

      namespace_record_delimeter =
        options.dig(:namespace_record_delimeter) || '$/'

      super
    end

    def call
      File.open(@source_filename, 'r') { |f| Oj.saj_parse(self, f) }

      # close input and output files
      # return Monad around file processing, output file close result
    end

    private

    # def each(&block)
    #   until @buffer.include?(namespace_record_delimeter)
    #     @buffer << @io.sysread(BufferLength)
    #   end

    #   line, @buffer = @buffer.split(namespace_record_delimeter, 2)

    #   block.call(line)
    #   each(&block)
    # rescue EOFError
    #   @io.close
    # end
  end
end

# This file defines the maps
module Medicaid
  module Transforms
    module IapTo
      class MitcInput < Operations::Transform
      end
    end
  end
end

# This how we call the operation
result =
  Medicaid::Transforms::IapTo::MitcInput.call(source_filename, output_filename)
result =
  Medicaid::Transforms::MitcResultTo::Iap.call(source_filename, output_filename)
# rubocop:enable all