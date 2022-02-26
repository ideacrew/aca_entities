# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Contracts
      # Schema and validation rules for the {AcaEntities::Ledger::AccountGroupContract} entity
      class AccountGroupContract < Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :id (optional)
        # @return [Dry::Monads::Result::Success] if params pass validation
        # @return [Dry::Monads::Result::Failure] if params fail validation
        params do
          optional(:id).maybe(:string)
          optional(:target).maybe(:string)
          optional(:number).maybe(:string)
          optional(:name).maybe(:string)
          optional(:parent).maybe(:string)
          optional(:is_result).maybe(:bool)
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
