# frozen_string_literal: true

module AcaEntities
  # Operations are perform Functions on domain entities
  module Operations
    module Operation
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

          super(*args.except(:operation))
        end

    end
  end
end
