# frozen_string_literal: true

module Qbo::Customers

  class CustomerContract < ApplicationContract

    json do
      
      required(:"DisplayName").value(Qbo::Types::StrippedString)
      required(:"PrimaryTaxIdentifier").value(Qbo::Types::StrippedString)
      optional(:"ExternalId").value(Qbo::Types::StrippedString)
      optional(:"GivenName").value(Qbo::Types::StrippedString)
      optional(:"FullyQualifiedName").value(Qbo::Types::StrippedString)
      optional(:"CompanyName").value(Qbo::Types::StrippedString)
      optional(:"FamilyName").value(Qbo::Types::StrippedString)

      optional(:Id).value(Qbo::Types::StrippedString)
      optional(:"SyncToken").value(Qbo::Types::StrippedString)
      optional(:"domain").value(Qbo::Types::StrippedString)

      optional(:"BillWithParent").value(:bool)
      optional(:"sparse").value(:bool)

      optional(:"BillAddr").maybe(:hash)

      optional(:"PrimaryEmailAddr").hash do
        optional(:"Address").maybe(Qbo::Types::StrippedString)
      end

      optional(:"PrimaryPhone").hash do
        optional(:"FreeFormNumber").maybe(Qbo::Types::StrippedString)
      end
      
      optional(:"Active").value(:bool)
      optional(:"MetaData").maybe(:hash)
      optional(:"Job").value(:bool)
      optional(:"Taxable").value(:bool)

      optional(:"BalanceWithJobs").value(Types::Coercible::Float)
      optional(:"Balance").value(Types::Coercible::Float)
      optional(:"PrintOnCheckName").value(Qbo::Types::StrippedString)
      optional(:"PreferredDeliveryMethod").value(Qbo::Types::StrippedString)

    end
  end
end
