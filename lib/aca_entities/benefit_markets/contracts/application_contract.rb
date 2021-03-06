# frozen_string_literal: true

Dry::Validation.load_extensions(:monads)

module AcaEntities
  module BenefitMarkets
    # Configuration values and shared rules and macros for domain model validation contracts
    class ApplicationContract < Dry::Validation::Contract

      # @!macro ruleeach
      #   Validates a nested array of $0 params
      #   @!method rule(product_packages)
      rule(:product_packages).each do
        if key && value && !value.is_a?(BenefitMarkets::ProductPackage)
          if value.is_a?(Hash)
            result = BenefitMarkets::Products::ProductPackageContract.new.call(value)
            key.failure(text: "invalid product package", error: result.errors.to_h) if result&.failure?
          else
            key.failure(text: "invalid product packages. expected a hash or product_package entity")
          end
        end
      end

      # @!macro ruleeach
      #   Validates a nested array of $0 params
      #   @!method rule(products)
      rule(:products).each do
        if key && value && !value.is_a?(BenefitMarkets::Product)
          if value.is_a?(Hash)
            kind = value[:kind].to_s.split('_').collect(&:capitalize).join
            contract_class = Class.const_get("AcaEntities::BenefitMarkets::Products::#{kind}ProductContract")
            result = contract_class.new.call(value)
            if result&.failure?
              key.failure(text: "invalid product", error: result.errors.to_h)
            else
              value.merge!(result.to_h)
            end
          else
            key.failure(text: "invalid products. expected a hash or product entity")
          end
        end
      end

      # @!macro ruleeach
      #   Validates a nested array of $0 params
      #   @!method rule(contribution_models)
      rule(:contribution_models).each do
        if key && value && !value.is_a?(BenefitMarkets::ContributionModel)
          if value.is_a?(Hash)
            result = BenefitMarkets::ContributionModels::ContributionModelContract.new.call(value)
            key.failure(text: "invalid contribution model", error: result.errors.to_h) if result&.failure?
          else
            key.failure(text: "invalid contribution models. expected a hash or contribution_model entity")
          end
        end
      end

      # @!macro ruleeach
      #   Validates a nested array of $0 params
      #   @!method rule(contribution_model)
      rule(:contribution_model) do
        if key && value && !value.is_a?(BenefitMarkets::ContributionModel)
          if value.is_a?(Hash)
            result = BenefitMarkets::ContributionModels::ContributionModelContract.new.call(value)
            key.failure(text: "invalid contribution model", error: result.errors.to_h) if result&.failure?
          else
            key.failure(text: "invalid contribution models. expected a hash or contribution_model entity")
          end
        end
      end

      rule(:pricing_model) do
        if key && value
          result = BenefitMarkets::PricingModels::PricingModelContract.new.call(value)
          key.failure(text: "invalid pricing model", error: result.errors.to_h) if result&.failure?
        end
      end
    end
  end
end