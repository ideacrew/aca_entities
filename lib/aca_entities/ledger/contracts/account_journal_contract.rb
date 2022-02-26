# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Contracts
      # Schema and validation rules for the {AcaEntities::Ledger::AccountJournalContract} entity
      class AccountJournalContract < Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :id (optional)
        # @return [Dry::Monads::Result::Success] if params pass validation
        # @return [Dry::Monads::Result::Failure] if params fail validation
        params do
          optional(:id).maybe(:string)
          optional(:number).maybe(:string)
          optional(:name).maybe(:string)
          optional(:date).maybe(:date)
          optional(:subject).maybe(:string)
          optional(:account_kind).maybe(:string)
          optional(:account_id).maybe(:integer)
          optional(:note).maybe(:string)
          optional(:permanent).maybe(:bool)
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
