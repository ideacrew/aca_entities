# frozen_string_literal: true

module AcaEntities
  module Locations
    module Addresses
      module Smarty
        class Lookup < Dry::Struct
          # An appplication-provided unique identifier for this address; this
          # field will be copied into the output
          attribute :input_id, Types::Coercible::String.meta(omittable: true)

          # The street line of the address, or the entire address ("freeform" input)
          # Freeform input can be up to 100 characters but only the first 50 will be
          # considered for the street portion of the address. Freeform inputs should
          # NOT include any form of country information (like "USA").
          attribute :street, Types::Coercible::String.meta(omittable: false)

          # Any extra address information (e.g., Leave it on the front porch.)
          attribute :street2, Types::Coercible::String.meta(omittable: true)

          # Apartment, suite, or office number (e.g., "Apt 52" or simply "52"; not "Apt52".)
          attribute :secondary, Types::Coercible::String.meta(omittable: true)

          # The city name
          attribute :city, Types::Coercible::String.meta(omittable: true)

          # The state name or abbreviation
          attribute :state, Types::Coercible::String.meta(omittable: true)

          # The ZIP Code
          attribute :zipcode, Types::Coercible::String.meta(omittable: true)

          # City, state, and ZIP Code combined
          attribute :lastline, Types::Coercible::String.meta(omittable: true)

          # The name of the person or company at this address
          attribute :addressee, Types::Coercible::String.meta(omittable: true)

          # The neighborhood (only for Puerto Rican addresses)
          attribute :urbanization, Types::Coercible::String.meta(omittable: true)

          # The maximum number of addresses returned when the input is ambiguous
          attribute :candidates, Types::Coercible::Integer.meta(omittable: true)

          # The match output strategy to be employed for this lookup. Valid values are:
          attribute :match, AcaEntities::Locations::Addresses::Smarty::Types::AddressMatchKind.meta(omittable: true)
        end
      end
    end
  end
end
