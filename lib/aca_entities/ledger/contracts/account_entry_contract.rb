# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Contracts
      # Schema and validation rules for {AcaEntities::Ledger::Transaction}
      class AccountEntryContract < Contract
        params do
          # required(:transaction_id).filled(:string)
          required(:date).filled(:date)
          required(:credits).array(AcaEntities::Ledger::Contracts::AccountCreditEntryContract.params)
          required(:debits).array(AcaEntities::Ledger::Contracts::AccountDebitEntryContract.params)
        end

        # Validate presence of at least one credit and one debit
        # rule(:credits, :debits).each { |index| }
      end
    end
  end
end
