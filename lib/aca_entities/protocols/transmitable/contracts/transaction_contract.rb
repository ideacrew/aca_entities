# frozen_string_literal: true

module AcaEntities
  module Protocols
    module Transmitable
      module Contracts
        # Schema and validation rules for the {AcaEntities::Evetns::Transmitable::Transaction} entity
        class TransactionContract < Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @return [Dry::Monads::Result::Success] if params pass validation
          # @return [Dry::Monads::Result::Failure] if params fail validation
          params do
            optional(:id).maybe(:string)
            optional(:transmission_id).value(:string)
            required(:name).value(:symbol)
            optional(:title).maybe(:string)
            optional(:description).maybe(:string)

            required(:started_at).value(:time)
            optional(:ended_at).maybe(:time)

            required(:status).value(:symbol)
            required(:process_states).array(AcaEntities::Protocols::Transmitable::Contracts::ProcessStateContract.params)
            optional(:errors).array(AcaEntities::Protocols::Transmitable::Contracts::ErrorsContract.params)

            optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
          end
        end
      end
    end
  end
end