# frozen_string_literal: true

module AcaEntities
  class Address < Dry::Struct

    # @!attribute [r] has_fixed_address
    # Whether applicant has a fixed address.
    # @return [String]
    attribute :has_fixed_address, Types::Bool.meta(omittable: false)
    attribute :kind,              Types::String.optional.meta(omittable: true)
    attribute :address_1,         Types::String.optional.meta(omittable: true)
    attribute :address_2,         Types::String.optional.meta(omittable: true)
    attribute :address_3,         Types::String.optional.meta(omittable: true)
    attribute :city,              Types::String.optional.meta(omittable: true)
    attribute :county,            Types::String.optional.meta(omittable: true)

    # @!attribute [r] county_code
    # Three digit county code (US Census)
    # @return [String]
    attribute :county_code,       Types::String.optional.meta(omittable: true)

    attribute :state,             Types::String.optional.meta(omittable: true)
    attribute :zip,               Types::String.optional.meta(omittable: true)
    attribute :country_name,      Types::String.optional.meta(omittable: true)
  end
end
