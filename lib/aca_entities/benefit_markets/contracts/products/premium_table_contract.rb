# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    module Products
      # Contract for PremiumTable
      class PremiumTableContract < Dry::Validation::Contract
        params do
          required(:effective_period).filled(type?: Range)
          required(:rating_area).filled(::AcaEntities::BenefitMarkets::Locations::RatingAreaContract.params)
          optional(:premium_tuples).array(::AcaEntities::BenefitMarkets::Products::PremiumTupleContract.params)
        end

        rule(:premium_tuples).each do
          if key && value
            result = PremiumTupleContract.new.call(value)
            key.failure(text: 'invalid premium tuple', error: result.errors.to_h) if result&.failure?
          end
        end

        rule(:rating_area).each do
          if key && value
            result = BenefitMarkets::Locations::RatingAreaContract.new.call(value)
            key.failure(text: 'invalid prating area', error: result.errors.to_h) if result&.failure?
          end
        end
      end
    end
  end
end
