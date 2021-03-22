# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Qbo
      module Locations
        # contract for Qbo address
        class AddressContract < ApplicationContract

          json do

            optional(:Id).value(Ledger::Qbo::Types::StrippedString)
            optional(:Line1).value(Ledger::Qbo::Types::StrippedString)
            optional(:City).value(Ledger::Qbo::Types::StrippedString)
            optional(:PostalCode).value(Ledger::Qbo::Types::StrippedString)
            optional(:Lat).value(Ledger::Qbo::Types::StrippedString)
            optional(:Long).value(Ledger::Qbo::Types::StrippedString)
            optional(:CountrySubDivisionCode).value(Ledger::Qbo::Types::StrippedString)

          end
        end
      end
    end
  end
end
