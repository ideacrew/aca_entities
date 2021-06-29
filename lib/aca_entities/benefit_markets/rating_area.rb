# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    # Entity for benefirmarkets RatingArea
    class RatingArea < Dry::Struct

      attribute :active_year,                         Types::Strict::Integer.meta(omittable: false)
      attribute :exchange_provided_code,              Types::Strict::String.meta(omittable: false)
      attribute :county_zip_ids,                      Types::Strict::Array.meta(omittable: false)
      attribute :covered_states,                      Types::Strict::Array.meta(omittable: false)

    end
  end
end