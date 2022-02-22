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
          optional(:name).maybe(:string)
          optional(:description).maybe(:string)
          optional(:number).maybe(:string)
          optional(:category).maybe(AcaEntities::Ledger::Types::AccountCategoryKind)
          optional(:kind).maybe(AcaEntities::Ledger::Types::AssetAccountKind)
          optional(:is_active).filled(:bool)
          optional(:scope).maybe(:string)
          optional(:balance).maybe(:float)
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
