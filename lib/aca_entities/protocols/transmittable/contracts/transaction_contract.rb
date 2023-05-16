# frozen_string_literal: true

module AcaEntities
  module Protocols
    module Transmittable
      module Contracts
        # Schema and validation rules for the {AcaEntities::Protocols::Transmittable::Transaction} entity
        class TransactionContract < Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @return [Dry::Monads::Result::Success] if params pass validation
          # @return [Dry::Monads::Result::Failure] if params fail validation
          params do
            optional(:id).maybe(:string)
            optional(:transaction_id).value(:string)
            required(:name).value(:symbol)
            optional(:title).maybe(:string)
            optional(:description).maybe(:string)

            required(:status).value(:symbol)
            required(:process_states).array(AcaEntities::Protocols::Transmittable::Contracts::ProcessStateContract.params)
            # optional(:transactions_transmissions).array(AcaEntities::Protocols::Transmittable::Contracts::TransactionsTransmissionsContract.params)

            required(:started_at).value(:date_time)
            optional(:ended_at).maybe(:date_time)
            required(:errors).array(AcaEntities::Protocols::Transmittable::Contracts::ErrorsContract.params)

            optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
          end
        end
      end
    end
  end
end