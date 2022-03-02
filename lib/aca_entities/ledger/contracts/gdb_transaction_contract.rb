# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Contracts
      # Schema and validation rules for {AcaEntities::Ledger::Transaction}
      class GdbTransactionContract < Contract
        params do
          required(:meta).filled(AcaEntities::Ledger::Contracts::MetaContract.params)
          optional(:customer).maybe(AcaEntities::Ledger::Contracts::CustomerContract.params)
        end
      end
    end
  end
end
