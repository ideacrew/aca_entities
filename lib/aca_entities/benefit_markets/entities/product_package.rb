# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    class ProductPackage < Dry::Struct
      transform_keys(&:to_sym)

      attribute :application_period,           Types::Range
      attribute :benefit_kind,                 Types::Strict::Symbol
      attribute :product_kind,                 Types::Strict::Symbol
      attribute :package_kind,                 Types::Strict::Symbol
      attribute :title,                        Types::Strict::String
      attribute :description,                  Types::String.optional

      attribute :products,                     Types::Array.of(BenefitMarkets::Product).optional
      attribute :contribution_model,           BenefitMarkets::ContributionModel
      attribute :assigned_contribution_model,  BenefitMarkets::ContributionModel.optional
      attribute :contribution_models,          Types::Array.of(BenefitMarkets::ContributionModel).optional
      attribute :pricing_model,                BenefitMarkets::PricingModel

    end
  end
end