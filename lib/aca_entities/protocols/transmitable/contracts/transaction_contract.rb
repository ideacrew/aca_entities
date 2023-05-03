# frozen_string_literal: true

module AcaEntities
  module Protocols
    module Transmitable
      module Contracts
        # Schema and validation rules for the {AcaEntities::Protocols::Transmitable::Transaction} entity
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

            required(:started_at).value(:date_time)
            optional(:ended_at).maybe(:date_time)

            required(:status).value(:symbol)
            # optional(:process_states).array(AcaEntities::Protocols::Transmitable::Contracts::ProcessStateContract.params)
            # optional(:transactions_transmissions).array(AcaEntities::Protocols::Transmitable::Contracts::TransactionsTransmissionsContract.params)
            required(:errors).array(AcaEntities::Protocols::Transmitable::Contracts::ErrorsContract.params)

            optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
          end
        end
      end
    end
  end
end