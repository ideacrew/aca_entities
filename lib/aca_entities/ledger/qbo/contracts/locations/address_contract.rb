# frozen_string_literal: true

module Qbo::Locations

  class AddressContract < ApplicationContract

    json do
      
      optional(:"Id").value(Qbo::Types::StrippedString)
      optional(:"Line1").value(Qbo::Types::StrippedString)
      optional(:"City").value(Qbo::Types::StrippedString)
      optional(:"PostalCode").value(Qbo::Types::StrippedString)
      optional(:"Lat").value(Qbo::Types::StrippedString)
      optional(:"Long").value(Qbo::Types::StrippedString)
      optional(:"CountrySubDivisionCode").value(Qbo::Types::StrippedString)
      
    end
  end
end
