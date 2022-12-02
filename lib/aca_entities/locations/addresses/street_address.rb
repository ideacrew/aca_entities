# frozen_string_literal: true

module AcaEntities
  module Locations
    module Addresses
      class StreetAddress < Dry::Struct
        attribute :id, Types::String.optional.meta(omittable: true)
        attribute :kind, AcaEntities::Locations::Types::AnyAddressKind.optional.meta(omittable: false)
        attribute :address_1, Types::String.optional.meta(omittable: false)
        attribute :address_2, Types::String.optional.meta(omittable: true)
        attribute :address_3, Types::String.optional.meta(omittable: true)
        attribute :city_name, Types::String.optional.meta(omittable: false)
        attribute :state_abbreviation, AcaEntities::Types::UsStateAbbreviationKind.optional.meta(omittable: false)
        attribute :zip_code, Types::String.optional.meta(omittable: false)
        attribute :zip_plus_four, Types::String.optional.meta(omittable: true)
        attribute :county_name, Types::String.optional.meta(omittable: true)

        # @!attribute [r] county_code
        # Three digit FIPS county code (US Census Bureau)
        # @return [String]
        attribute :county_fips_code, Types::String.optional.meta(omittable: true)

        # @!attribute [r] state_fips_code
        # Two digit FIPS state code (US Census Bureau)
        # @return [String]
        attribute :state_fips_code, Types::String.optional.meta(omittable: true)

        attribute :country_name, Types::String.optional.meta(omittable: true)
        attribute :country_code, Types::String.optional.meta(omittable: true)

        # Indicates whether the address information has been validated with the USPS.
        attribute :validation_status, AcaEntities::Locations::Addresses::ValidationStatus.optional.meta(omittable: true)

        attribute :start_on, Types::Date.optional.meta(omittable: true)
        attribute :end_on, Types::Date.optional.meta(omittable: true)
        attribute :timestamps, AcaEntities::TimeStamp.meta(omittable: true)
      end
    end
  end
end
