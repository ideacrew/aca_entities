# frozen_string_literal: true

# Model based on ERI Indoors data model
# https://pro.arcgis.com/en/pro-app/help/data/indoors/map-floor-plans-to-indoors.htm
module Facilities

  # A building or structure asset
  class Facility < Dry::Struct
    
    attribute :id,            Types::Integer.meta(omittable: true)
    attribute :region,        Types::String.optional.meta(omittable: true)
    attribute :facility_kind, Types::String.meta(omittable: true)
    attribute :name,          Types::String.meta(omittable: true)
    attribute :status,        Types::String.meta(omittable: true)
    attribute :location,      Locations::Location.optional.meta(omittable: true)
    attribute :account,       Accounts::Account.optional.meta(omittable: true)
    attribute :levels,        Types::Array.of(Facilities::Level).meta(omittable: true)
    attribute :address,       Locations::Address.optional.meta(omittable: true)

  end
end
