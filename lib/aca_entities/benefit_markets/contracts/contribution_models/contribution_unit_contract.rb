# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    module ContributionModels
      # Contract for ContributionUnit
      class ContributionUnitContract < Dry::Validation::Contract

        params do
          required(:name).filled(:string)
          required(:display_name).filled(:string)
          required(:order).filled(:integer)
          required(:member_relationship_maps).array(BenefitMarkets::PricingModels::MemberRelationshipMapContract.params)
        end

        rule(:member_relationship_maps).each do
          if key && value
            result = BenefitMarkets::PricingModels::MemberRelationshipMapContract.new.call(value)
            key.failure(text: "invalid member relationship maps for contribution unit", error: result.errors.to_h) if result&.failure?
          end
        end
      end
    end
  end
end