# frozen_string_literal: true

module AcaEntities
  module Locations
    class Address < Dry::Struct

      # @!attribute [r] has_fixed_address
      # Whether applicant has a fixed address.
      # @return [String]
      attribute :has_fixed_address, Types::Bool.optional.meta(omittable: true)
      attribute :kind,              Types::AddressKinds.optional.meta(omittable: false)
      attribute :address_1,         Types::String.optional.meta(omittable: false)
      attribute :address_2,         Types::String.optional.meta(omittable: true)
      attribute :address_3,         Types::String.optional.meta(omittable: true)
      attribute :city,              Types::String.optional.meta(omittable: false)
      attribute :county,            Types::String.optional.meta(omittable: true)

      # @!attribute [r] county_code
      # Three digit county code (US Census)
      # @return [String]
      attribute :county_code,       Types::String.optional.meta(omittable: true)

      attribute :state,             Types::UsStateAbbreviationKind.optional.meta(omittable: false)
      attribute :zip,               Types::String.optional.meta(omittable: false)
      attribute :country_name,      Types::String.optional.meta(omittable: true)

      # Indicates whether the address information has been validated with the USPS.
      attribute :validation_status, Types::String.optional.meta(omittable: true)

      attribute :start_on, Types::Date.optional.meta(omittable: true)
      attribute :end_on, Types::Date.optional.meta(omittable: true)

      attribute :lives_outside_state_temporarily, Types::Bool.optional.meta(omittable: true)
      attribute :geocode, Types::String.optional.meta(omittable: true)
    end
  end
end
