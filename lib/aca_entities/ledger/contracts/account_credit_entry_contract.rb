# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Contracts
      # Schema and validation rules for {AcaEntities::Ledger::AccountCreditEntry}
      class AccountCreditEntryContract < Contract
        params do
          required(:account).filled(AcaEntities::Ledger::Contracts::AccountContract.params)
          required(:amount).filled(AcaEntities::Types::Money)
          required(:side).filled(AcaEntities::Ledger::Types::KeeprSideKind)
        end
      end
    end
  end
end
