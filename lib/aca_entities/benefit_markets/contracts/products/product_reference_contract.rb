# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    module Products
      # Schema and validation rules for {AcaEntities::BenefitMarkets::Products::ProductReference}
      class ProductReferenceContract < Dry::Validation::Contract
        params do
          required(:hios_id).filled(:string)
          required(:name).filled(:string)
          required(:active_year).filled(:integer)
          required(:is_dental_only).filled(:bool)
          required(:metal_level).filled(:string)
          required(:benefit_market_kind).filled(:string)
          required(:product_kind).filled(:string)
          optional(:ehb_percent).maybe(:string)
          required(:issuer_profile_reference).hash(AcaEntities::Contracts::Organizations::IssuerProfileReferenceContract.params)
        end
      end
    end
  end
end