# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Contracts
      # Schema and validation rules for the {AcaEntities::Ledger::AccountContract} entity
      class AccountContract < Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :id (optional)
        # @return [Dry::Monads::Result::Success] if params pass validation
        # @return [Dry::Monads::Result::Failure] if params fail validation
        params do
          optional(:id).maybe(:string)
          required(:number).filled(:integer)
          required(:name).filled(:string)
          required(:kind).filled(AcaEntities::Ledger::Types::KeeprAccountKind)
          optional(:parent).maybe(:hash)

          # optional(:parent).maybe(AcaEntities::Ledger::Contracts::AccountContract.params)
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
