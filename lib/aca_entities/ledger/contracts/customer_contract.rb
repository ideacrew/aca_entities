# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Contracts
      # Schema and validation rules for {AcaEntities::Ledger::Customer}
      class CustomerContract < Contract
        params do
          required(:DisplayName).value(Ledger::Qbo::Types::StrippedString)
          required(:PrimaryTaxIdentifier).value(Ledger::Qbo::Types::StrippedString)
          optional(:ExternalId).value(Ledger::Qbo::Types::StrippedString)
          optional(:GivenName).value(Ledger::Qbo::Types::StrippedString)
          optional(:FullyQualifiedName).value(Ledger::Qbo::Types::StrippedString)
          optional(:CompanyName).value(Ledger::Qbo::Types::StrippedString)
          optional(:FamilyName).value(Ledger::Qbo::Types::StrippedString)

          optional(:Id).value(Ledger::Qbo::Types::StrippedString)
          optional(:SyncToken).value(Ledger::Qbo::Types::StrippedString)
          optional(:domain).value(Ledger::Qbo::Types::StrippedString)

          optional(:BillWithParent).value(:bool)
          optional(:sparse).value(:bool)

          optional(:BillAddr).maybe(:hash)

          optional(:PrimaryEmailAddr).hash { optional(:Address).maybe(Ledger::Qbo::Types::StrippedString) }

          optional(:PrimaryPhone).hash { optional(:FreeFormNumber).maybe(Ledger::Qbo::Types::StrippedString) }

          optional(:Active).value(:bool)
          optional(:MetaData).maybe(:hash)
          optional(:Job).value(:bool)
          optional(:Taxable).value(:bool)

          optional(:BalanceWithJobs).value(Types::Coercible::Float)
          optional(:Balance).value(Types::Coercible::Float)
          optional(:PrintOnCheckName).value(Ledger::Qbo::Types::StrippedString)
          optional(:PreferredDeliveryMethod).value(Ledger::Qbo::Types::StrippedString)
        end
      end
    end
  end
end
