# frozen_string_literal: true

module AcaEntities
  module Protocols
    module Transmittable
      module Operations
        module Transactions
          # Create a new transaction
          class Create
            send(:include, Dry::Monads[:result, :do, :try])

            # @param [Hash] params The options to create a Transaction with
            def call(params)
              values = yield validate(params)
              transaction = yield create(values)

              Success(transaction)
            end

            private

            # @param [Hash] params The options to create a Transaction with
            # @return [Dry::Monads::Result::Success] if params pass validation
            # @return [Dry::Monads::Result::Failure] if params fail validation
            def validate(params)
              result = Contracts::Transactions::Create.new.call(params)
              result.success? ? Success(result) : Failure(result)
            end

            # @param [Hash] values The validated options to create a Transaction with
            # @return [Dry::Monads::Result::Success] if Transaction is created
            # @return [Dry::Monads::Result::Failure] if Transaction is not created
            def create(values)
              Try do
                Transaction.new(values.to_h)
              end.to_result
            end
          end
        end
      end
    end
  end
end
