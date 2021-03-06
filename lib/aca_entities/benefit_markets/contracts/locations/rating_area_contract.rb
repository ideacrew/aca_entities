# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    module Locations
      # Contract for RatingArea
      class RatingAreaContract < Dry::Validation::Contract

        params do
          required(:active_year).filled(:integer)
          required(:exchange_provided_code).filled(:string)
          required(:county_zip_ids).array(:hash)
          required(:covered_states).array(:hash)
        end

      end
    end
  end
end