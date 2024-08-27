# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    module Products
      # Contract for HealthProduct
      class PremiumValueProductContract < Dry::Validation::Contract
        params do
          required(:product_id).filled(:string)
          required(:rating_area_id).filled(:string)
          required(:hios_id).filled(:string)
          required(:active_year).filled(:integer)
        end
      end
    end
  end
end