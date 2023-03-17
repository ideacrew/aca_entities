# frozen_string_literal: true

module AcaEntities
  # An Operation with one or more sub-CompositeOperations
  module Operations
    module CompositeOperation
        # Class methods
        def self.included(base)
          base.extend(ClassMethods)
        end

        module ClassMethods
          def call(args)
            operation = args.slice(:operation)
            new(operation).call(args.except(:operation))
          end
        end

        attr_accessor :operation_name, :parent

        def initialize(args)
          @operation_name = args.dig(:operation,:operation_name)
          raise ArgumentError.new "{ operation: { :operation_name } } required" if @operation_name.nil?
          @parent = nil
          @sub_operations = []

          super(*args.except(:operation))
        end

        def add_sub_operation(operations)
          @sub_operations << operation
          operation.parent = self
        end

        def remove_sub_operation(operations)
          @sub_operations.delete(operations)
          operation.parent = nil
        end
    
    end
  end
end
