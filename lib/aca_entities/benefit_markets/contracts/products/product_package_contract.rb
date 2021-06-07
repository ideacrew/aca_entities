# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    module Products
      # Contract for ProductPackage
      class ProductPackageContract < BenefitMarkets::ApplicationContract

        params do
          required(:package_kind).filled(:symbol)
          required(:application_period).value(type?: Range)
          required(:benefit_kind).filled(:symbol)
          required(:product_kind).filled(:symbol)
          required(:title).filled(:string)
          required(:contribution_models).array(BenefitMarkets::ContributionModels::ContributionModelContract.params)
          required(:pricing_model).filled(BenefitMarkets::PricingModels::PricingModelContract.params)
          required(:products).array(:hash)
          optional(:description).maybe(:string)
          required(:contribution_model).value(BenefitMarkets::ContributionModels::ContributionModelContract.params)
          required(:assigned_contribution_model).value(BenefitMarkets::ContributionModels::ContributionModelContract.params)
        end

        rule(:assigned_contribution_model) do
          if key && value && !value.is_a?(BenefitMarkets::ContributionModel)
            if value.is_a?(Hash)
              result = BenefitMarkets::ContributionModels::ContributionModelContract.new.call(value)
              key.failure(text: "invalid assigned contribution model", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid assigned contribution models. expected a hash or contribution_model entity")
            end
          end
        end
      end
    end
  end
end