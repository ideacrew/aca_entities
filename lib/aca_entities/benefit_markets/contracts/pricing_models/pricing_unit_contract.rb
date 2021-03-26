# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    module PricingModels
      # Contract for PricingUnit
      class PricingUnitContract < Dry::Validation::Contract

        params do
          # required(:_id).filled(Types::Bson)
          required(:name).filled(:string)
          required(:display_name).filled(:string)
          required(:order).filled(:integer)
        end
      end
    end
  end
end