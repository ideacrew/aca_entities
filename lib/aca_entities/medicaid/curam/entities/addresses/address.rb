# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Addresses
        # Street Address entity and it's attributes
        class Address < Dry::Struct
          # Street address type from enumerated list
          attribute :type,    Types::AddressKind.meta(omittable: false)

          # First line of street address.  Typically house number, street name and direction, e.g. NE, NW. SE, SW (required)
          attribute :line_1,  Types::String.meta(omittable: false)

          # Second line of street address.  Typically used for apartment or unit number (optional)
          attribute :line_2,  Types::String.optional.meta(omittable: true)

          # Town or city name. (Required)
          attribute :city,    Types::String.meta(omittable: false)

          # State name from enumerated list (required)
          attribute :state,   Types::UsStateKind.meta(omittable: false)

          # Five digit postal code (required)
          attribute :zip,     Types::Coercible::String.meta(omittable: false)
        end
      end
    end
  end
end
