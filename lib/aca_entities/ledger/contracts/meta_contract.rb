# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Contracts
      # Schema and validation rules for {AcaEntities::Ledger::Transaction}
      class MetaContract < Contract
        params do
          required(:transaction_header).filled(AcaEntities::Ledger::Contracts::TransactionHeaderContract.params)
        end
      end
    end
  end
end
