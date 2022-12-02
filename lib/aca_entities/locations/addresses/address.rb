# frozen_string_literal: true

module AcaEntities
  module Locations
    module Addresses
      class Address < Dry::Struct
        # @!attribute [r] has_fixed_address
        # Whether applicant has a fixed address.
        # @return [String]
        attribute :has_fixed_address, Types::Bool.optional.meta(omittable: true)
        attribute :kind, Types::AddressKinds.optional.meta(omittable: false)
        attribute :address_1, Types::String.optional.meta(omittable: false)
        attribute :address_2, Types::String.optional.meta(omittable: true)
        attribute :address_3, Types::String.optional.meta(omittable: true)
        attribute :city, Types::String.optional.meta(omittable: false)
        attribute :state, AcaEntities::Types::UsStateAbbreviationKind.optional.meta(omittable: false)
        attribute :zip, Types::String.optional.meta(omittable: false)

        # @!attribute [r] county
        # US County Name
        # @return [String]
        attribute :county, Types::String.optional.meta(omittable: true)

        # @!attribute [r] county_code
        # Three digit FIPS county code (US Census Bureau)
        # @return [String]
        attribute :county_code, Types::String.optional.meta(omittable: true)
        attribute :country_name, Types::String.optional.meta(omittable: true)

        # Indicates whether the address information has been validated with the USPS.
        attribute :validation_status, Types::String.optional.meta(omittable: true)

        # @!attribute [r] start_on
        # Date when this address became active for the party
        # @return [Date]
        attribute :start_on, Types::Date.optional.meta(omittable: true)

        # @!attribute [r] end_on
        # Date through which this address was active for the party
        # @return [Date]
        attribute :end_on, Types::Date.optional.meta(omittable: true)

        attribute :lives_outside_state_temporarily, Types::Bool.optional.meta(omittable: true)
        attribute :geocode, Types::String.optional.meta(omittable: true)

        def full_address
          formatted_address.to_s.gsub('\n', ' ')
        end

        def formatted_address
          city_state = [city, state].join(',')
          [address_1, address_2, address_3, city_state].compact.join('\n')
        end
      end
    end
  end
end
