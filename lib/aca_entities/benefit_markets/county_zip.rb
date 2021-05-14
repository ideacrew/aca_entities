# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    # Entity for benefirmarkets countyzip
    class CountyZip < Dry::Struct

      attribute :county_name,    Types::Strict::String.meta(omittable: false)
      attribute :zip,            Types::Strict::String.meta(omittable: false)
      attribute :state,          Types::Strict::String.meta(omittable: false)
    end
  end
end