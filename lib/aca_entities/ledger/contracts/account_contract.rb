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
          optional(:id).filled(:string)
          optional(:name).filled(:string)
          optional(:description).filled(:string)
          optional(:number).filled(:string)
          optional(:kind).filled(:string)
          optional(:category).filled(:string)
          optional(:is_active).value(:bool)
          optional(:scope).value(:string)
          optional(:balance).value(:float)
          optional(:timestamps).filled(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
