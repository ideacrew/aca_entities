# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    module Locations
      # Contract for CountyZip
      class CountyZipContract < Dry::Validation::Contract

        params do
          required(:county_name).filled(:string)
          required(:zip).filled(:string)
          required(:state).filled(:string)
        end
      end
    end
  end
end