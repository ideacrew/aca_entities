# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Contracts
      # Schema and validation rules for {AcaEntities::Ledger::UserFee}
      class UserFeeContract < Contract
        params do
          optional(:id).maybe(:string)
          optional(:name).maybe(:string)
          optional(:description).maybe(:string)
          required(:effective_year).filled(:integer)
          required(:rate).filled(:decimal)
          required(:income_account).filled(AcaEntities::Ledger::Contracts::AccountContract.params)
          optional(:expense_account).maybe(AcaEntities::Ledger::Contracts::AccountContract.params)
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
