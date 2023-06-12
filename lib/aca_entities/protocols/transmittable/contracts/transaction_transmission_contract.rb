# frozen_string_literal: true

module AcaEntities
  module Protocols
    module Transmittable
      module Contracts
        # Schema and validation rules for the {AcaEntities::Protocols::Transmittable::TransactionTransmission} entity
        class TransactionsTransmissionsContract < Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @return [Dry::Monads::Result::Success] if params pass validation
          # @return [Dry::Monads::Result::Failure] if params fail validation
          params do
            required(:transactions).hash do
              required(:transaction).value(AcaEntities::Protocols::Transmittable::Contracts::TransactionContract.params)
              required(:transmissions).array(AcaEntities::Protocols::Transmittable::Contracts::TransmissionContract.params)
            end
            required(:transmissions).hash do
              required(:transmission).value(AcaEntities::Protocols::Transmittable::Contracts::TransmissionContract.params)
              required(:transactions).array(AcaEntities::Protocols::Transmittable::Contracts::TransactionsContract.params)
            end
          end
        end
      end
    end
  end
end