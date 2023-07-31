# frozen_string_literal: true

module AcaEntities
  module Protocols
    module Transmittable
      module Operations
        module TransmittableErrors
          # Create a new process state
          class Create
            send(:include, Dry::Monads[:result, :do, :try])

            # @param [Hash] params The options to create a Transaction with
            def call(params)
              values = yield validate(params)
              error = yield create(values)

              Success(error)
            end

            private

            def validate(params)
              result = Contracts::TransmittableErrorContract.new.call(params)
              result.success? ? Success(result) : Failure(result)
            end

            def create(values)
              Try do
                TransmittableError.new(values.to_h)
              end.to_result
            end
          end
        end
      end
    end
  end
end
