# frozen_string_literal: true

module Qbo::Vendors

  class VendorContract < ApplicationContract

    json do

      required(:"DisplayName").value(Qbo::Types::StrippedString)
      optional(:"GivenName").value(Qbo::Types::StrippedString)
      optional(:"FamilyName").value(Qbo::Types::StrippedString)

      optional(:Id).value(Qbo::Types::StrippedString)
      optional(:"SyncToken").value(Qbo::Types::StrippedString)
      optional(:"domain").value(Qbo::Types::StrippedString)
      optional(:"Vendor1099").value(:bool)

      optional(:"AcctNum").value(Qbo::Types::StrippedString)
      optional(:"CompanyName").value(Qbo::Types::StrippedString)
      optional(:"BillAddr").maybe(:hash)

      optional(:"WebAddr").hash do
        optional(:"URI").value(Qbo::Types::StrippedString)
      end

      optional(:"PrimaryEmailAddr").hash do
        optional(:"Address").value(Qbo::Types::StrippedString)
      end

      optional(:"PrimaryPhone").hash do
        optional(:"FreeFormNumber").value(Qbo::Types::StrippedString)
      end
      
      optional(:"Active").value(:bool)
      optional(:"sparse").value(:bool)
      optional(:"MetaData").maybe(:hash)

      optional(:"Balance").value(Types::Coercible::Float)
      optional(:"PrintOnCheckName").value(Qbo::Types::StrippedString)

    end
  end
end
