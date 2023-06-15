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
              # this is the transaction object hash
              required(:transaction).filled(:hash)
              # this is the transmission object hash
              required(:transmissions).array(:hash)
            end

            required(:transmissions).hash do
              # this is the transmission object hash
              required(:transmission).filled(:hash)
              # this is the transaction object hash
              required(:transactions).array(:hash)
            end
          end
        end
      end
    end
  end
end