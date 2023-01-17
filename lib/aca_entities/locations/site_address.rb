# frozen_string_literal: true

module AcaEntities
  module Locations
    class SiteAddress < Dry::Struct
      attribute :id, Types::String.optional.meta(omittable: true)
      attribute :kind, Types::AddressKinds.optional.meta(omittable: false)
      attribute :address_1, Types::String.optional.meta(omittable: false)
      attribute :address_2, Types::String.optional.meta(omittable: true)
      attribute :address_3, Types::String.optional.meta(omittable: true)
      attribute :city, Types::String.optional.meta(omittable: false)
      attribute :state_abbreviation, Types::UsStateAbbreviationKind.optional.meta(omittable: false)

      attribute :county_name, Types::String.optional.meta(omittable: true)

      # @!attribute [r] county_code
      # Federal three digit county code (US Census)
      # @return [String]
      attribute :county_fips_code, Types::String.optional.meta(omittable: true)

      attribute :zip_code, Types::String.optional.meta(omittable: false)
      attribute :zip_plus_four, Types::String.optional.meta(omittable: true)

      attribute :country_name, Types::String.optional.meta(omittable: true)
      attribute :country_code, Types::String.optional.meta(omittable: true)
      attribute :state_fips_code, Types::String.optional.meta(omittable: true)

      attribute :validation_status, AcaEntities::Locations::AddressValidationStatus.optional.meta(omittable: true)

      # Indicates whether the address information has been validated with the USPS.
      # attribute :validation_status, Types::String.optional.meta(omittable: true)

      attribute :start_on, Types::Date.optional.meta(omittable: true)
      attribute :end_on, Types::Date.optional.meta(omittable: true)
      attribute :timestamps, AcaEntities::TimeStamp.meta(omittable: true)
    end
  end
end
