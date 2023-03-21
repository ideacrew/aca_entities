# frozen_string_literal: true

module AcaEntities
  module Operations
    # CompositeOperation is branch node in an Operations tree structure, containing other
    # CompositeOperations and Operations
    module CompositeOperation
      # Class methods
      def self.included(base)
        base.extend(ClassMethods)
      end

      # Class methods for the CompositeOperation mixin
      module ClassMethods
        def call(args)
          operation = args.slice(:operation)
          new(operation).call(args.except(:operation))
        end
      end

      attr_accessor :operation_name, :parent, :sub_operations

      def initialize(args)
        @operation_name = args.dig(:operation, :operation_name)
        raise(ArgumentError.new, '{ operation: { :operation_name } } required') if @operation_name.nil?
        @parent = nil
        @sub_operations = []

        super(*args.except(:operation))
      end

      def add_sub_operation(operation)
        @sub_operations << operation
        operation.parent = self
      end

      def remove_sub_operation(operation)
        @sub_operations.delete(operation)
        operation.parent = nil
      end
    end
  end
end
