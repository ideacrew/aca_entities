# frozen_string_literal: true

module AcaEntities
  module Protocols
    module Transmittable
      module Operations
        module Transmissions
          # Create a new transmission
          class Create
            send(:include, Dry::Monads[:result, :do, :try])

            # @param [Hash] params The options to create a transmission with
            def call(params)
              values = yield validate(params)
              transmission = yield create(values)

              Success(transmission)
            end

            private

            # @param [Hash] params The options to create a transmission with
            # @return [Dry::Monads::Result::Success] if params pass validation
            # @return [Dry::Monads::Result::Failure] if params fail validation
            def validate(params)
              result = Contracts::TransmissionContract.new.call(params)
              result.success? ? Success(result) : Failure(result)
            end

            # @param [Hash] values The validated options to create a transmission with
            # @return [Dry::Monads::Result::Success] if transmission is created
            # @return [Dry::Monads::Result::Failure] if transmission is not created
            def create(values)
              Try do
                Transmission.new(values.to_h)
              end.to_result
            end
          end
        end
      end
    end
  end
end
