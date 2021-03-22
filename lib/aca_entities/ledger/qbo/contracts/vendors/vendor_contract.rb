# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Qbo
      module Vendors
        # contract for Qbo vendor
        class VendorContract < ApplicationContract

          json do

            required(:DisplayName).value(Ledger::Qbo::Types::StrippedString)
            optional(:GivenName).value(Ledger::Qbo::Types::StrippedString)
            optional(:FamilyName).value(Ledger::Qbo::Types::StrippedString)

            optional(:Id).value(Ledger::Qbo::Types::StrippedString)
            optional(:SyncToken).value(Ledger::Qbo::Types::StrippedString)
            optional(:domain).value(Ledger::Qbo::Types::StrippedString)
            optional(:Vendor1099).value(:bool)

            optional(:AcctNum).value(Ledger::Qbo::Types::StrippedString)
            optional(:CompanyName).value(Ledger::Qbo::Types::StrippedString)
            optional(:BillAddr).maybe(:hash)

            optional(:WebAddr).hash do
              optional(:URI).value(Ledger::Qbo::Types::StrippedString)
            end

            optional(:PrimaryEmailAddr).hash do
              optional(:Address).value(Ledger::Qbo::Types::StrippedString)
            end

            optional(:PrimaryPhone).hash do
              optional(:FreeFormNumber).value(Ledger::Qbo::Types::StrippedString)
            end

            optional(:Active).value(:bool)
            optional(:sparse).value(:bool)
            optional(:MetaData).maybe(:hash)

            optional(:Balance).value(Types::Coercible::Float)
            optional(:PrintOnCheckName).value(Ledger::Qbo::Types::StrippedString)

          end
        end
      end
    end
  end
end
