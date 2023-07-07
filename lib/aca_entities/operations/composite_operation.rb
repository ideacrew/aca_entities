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
        send(:include, Dry::Monads[:do])

        def call(args)
          operation = args.slice(:operation)
          new(operation).call(args.except(:operation))
        end
      end

      # @attr [Symbol] operation_name name assigned to this operation
      # @attr [Operation, CompositeOperation] the parent node operation of this operation
      # @attr [Array<Operation>, Array<CompositeOperation>] child nodes of this operation
      attr_accessor :operation_name, :parent, :child_operations

      def initialize(args)
        @operation_name = args.dig(:operation, :operation_name)

        raise(ArgumentError.new, '{ operation: { :operation_name } } required') if @operation_name.nil?
        @parent = nil
        @child_operations = []

        super(*args.except(:operation))
      end

      # Add a child operation to this CompositeOperation.
      # @param [Operation, CompositeOperation] operation the operation object to be added
      # A Failure monad is returned if the operation  error is returned if the operation is not found
      # @return [CompositeOperation, Failure] return the object or Failure monad in case of error
      def add_child_operation(operation)
        unless operation.is_a?(Operation) || operation.is_a?(CompositeOperation)
          return Failure("expected Operation || CompositeOperation, got: #{operation.class.name}")
        end

        if child_operation_names.include? operation.operation_name
          msg = "duplicate child operation name: :#{operation.operation_name}"
          return Failure(msg)
        end

        @child_operations << operation
        operation.parent = self
      end

      # Remove an operation added to this CompositeOperation.
      # @param [Operation, CompositeOperation] operation the operation object to be removed
      # No error is returned if the operation is not found
      # @return [CompositeOperation] return the object
      def drop_child_operation(operation)
        if child_operation_names.include? operation.operation_name
          @child_operations.delete(operation)
          operation.parent = nil
        end
        self
      end

      # Return names of added operations
      # @return [Array<Symbol>] list of operation names
      def child_operation_names
        child_operations.map(&:operation_name)
      end
    end
  end
end
