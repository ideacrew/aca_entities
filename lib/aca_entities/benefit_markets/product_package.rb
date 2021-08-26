# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    # Entity for benefirmarkets ProductPackage
    class ProductPackage < Dry::Struct

      attribute :application_period,           Types::Range.meta(omittable: false)
      attribute :benefit_kind,                 Types::Strict::Symbol.meta(omittable: false)
      attribute :product_kind,                 Types::Strict::Symbol.meta(omittable: false)
      attribute :package_kind,                 Types::Strict::Symbol.meta(omittable: false)
      attribute :title,                        Types::Strict::String.meta(omittable: false)
      attribute :description,                  Types::String.optional.meta(omittable: true)

      attribute :products,                     Types::Array.of(BenefitMarkets::Product).meta(omittable: false)
      attribute :contribution_model,           BenefitMarkets::ContributionModel.meta(omittable: false)
      attribute :assigned_contribution_model,  BenefitMarkets::ContributionModel.meta(omittable: false)
      attribute :contribution_models,          Types::Array.of(BenefitMarkets::ContributionModel).meta(omittable: false)
      attribute :pricing_model,                BenefitMarkets::PricingModel.meta(omittable: false)

    end
  end
end