# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    module ContributionModels
      # Contract for BenefitMarket ContributionModel
      class ContributionModelContract < Dry::Validation::Contract

        params do
          required(:title).filled(:string)
          optional(:key).maybe(:symbol)
          required(:sponsor_contribution_kind).filled(:string)
          required(:contribution_calculator_kind).filled(:string)
          required(:many_simultaneous_contribution_units).filled(:bool)
          required(:product_multiplicities).array(:symbol)
          required(:contribution_units).array(BenefitMarkets::ContributionModels::ContributionUnitContract.params)
          required(:member_relationships).array(BenefitMarkets::PricingModels::MemberRelationshipContract.params)
        end

        rule(:contribution_units).each do
          next unless key && value
          contribution_units = [AcaEntities::BenefitMarkets::FixedPercentContributionUnit, AcaEntities::BenefitMarkets::FixedDollarContributionUnit,
                                AcaEntities::BenefitMarkets::PercentWithCapContributionUnit]
          unless contribution_units.include?(value.class)
            if value.is_a?(Hash)
              result = BenefitMarkets::ContributionModels::ContributionUnitContract.new.call(value)
              key.failure(text: "invalid contribution unit", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid contribution_units. Expected a hash or contribution unit entity")
            end
          end
        end

        rule(:member_relationships).each do
          if key && value
            result = BenefitMarkets::PricingModels::MemberRelationshipContract.new.call(value)
            key.failure(text: "invalid member relationshp for contribution model", error: result.errors.to_h) if result&.failure?
          end
        end
      end
    end
  end
end