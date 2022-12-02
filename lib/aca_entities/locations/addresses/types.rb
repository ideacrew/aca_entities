# frozen_string_literal: true

require 'dry-types'

module AcaEntities
  module Locations
    module Addresses
      # Custom Locations::Addresses Types
      module Types
        send(:include, Dry.Types)
        include Dry::Logic

        StreetPredirectionKind = Types::Coercible::String.enum('N', 'S', 'E', 'W', 'North', 'South', 'East', 'West')
        StreetPostdirectionKind = Types::Coercible::String.enum('NE', 'SE', 'SW', 'NW')

        AnyAddressKind =
          Types::Coercible::String.enum('home', 'work', 'billing', 'shipping', 'headquarters', 'satellite')
        AddressKinds = Types::Coercible::String.enum('home', 'work', 'mailing', 'primary', 'branch')

        PersonAddressKind = Types::Coercible::String.enum('home', 'work', 'billing', 'shipping')
        OrganizationAddressKind = Types::Coercible::String.enum('headquarters', 'satellite', 'billing', 'shipping')

        ContactAddressKindMap = { billing: 'Billing', shipping: 'Shipping', work: 'Work', home: 'Home' }.freeze
        AccountAddressKindMap = {
          billing: 'Billing',
          shipping: 'Shipping',
          satellite: 'Satellite',
          headquarters: 'Headquarters'
        }.freeze

        # Latitude coordinate as a positive or neditive float value in decimal degrees format
        LatitudeKind = Types::Coercible::Float.constrained(gteq: -90.0, lteq: 90.0)

        # Longitude coordinate as a positive or neditive float value in decimal degrees format
        LongitudeKind = Types::Coercible::Float.constrained(gteq: -180.0, lteq: 180.0)

        CallableDate = Types::Date.default { Date.today }
        CallableDateTime = Types::DateTime.default { DateTime.now }

        HashOrNil = Types::Hash | Types::Nil
        StringOrNil = Types::String | Types::Nil

        RequiredString = Types::Strict::String.constrained(min_size: 1)
        StrippedString = Types::String.constructor(&:strip)
        SymbolOrString = Types::Symbol | Types::String
        NilOrString = Types::Nil | Types::String

        CoercedInteger = Types::Coercible::Integer | Types::Coercible::Float.constructor(&:to_i)

        Callable = Types.Interface(:call)
      end
    end
  end
end
