# frozen_string_literal: true

module Locations
  class Address < Dry::Struct

    ContactAddressKindMap  = { billing: "Billing", shipping: "Shipping", work: "Work", home: "Home" }
    AccountAddressKindMap  = { billing: "Billing", shipping: "Shipping", satellite: "Satellite", headquarters: "Headquarters" }

    attribute :street1,               Types::String.meta(omittable: true)
    attribute :street2,               Types::String.meta(omittable: true)
    attribute :city,                  Types::String.meta(omittable: true)
    attribute :state_abbreviation,    Types::String.meta(omittable: true)
    attribute :state,                 Types::String.meta(omittable: true)
    attribute :zipcode,               Types::String.meta(omittable: true)
    attribute :county,                Types::String.meta(omittable: true)
    attribute :fipscode,              Types::String.meta(omittable: true)
    attribute :country,               Types::String.meta(omittable: true)
    
    attribute :full_address,          Types::String.meta(omittable: true)
    attribute :address_type,          CovidMost::Types::ContactAddressKind.meta(omittable: true)
    attribute :addressable_type,      Types::String.meta(omittable: true)
    attribute :addressable_id,        Types::String.meta(omittable: true)

    attribute :state_code,            Types::Integer.meta(omittable: true)
    attribute :county_code,           Types::Integer.meta(omittable: true)
    attribute :latitude,              Types::Float.meta(omittable: true)
    attribute :longitude,             Types::Float.meta(omittable: true)
    # TODO: Needs to be RGeo::Geographic::SphericalPointImpl or something
    attribute :lonlat,                Types::String.optional.meta(omittable: true)

  end
end
