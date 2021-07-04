# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    module Products
      # Contract for PremiumTuple
      class PremiumTupleContract < Dry::Validation::Contract

        params do
          required(:age).filled(:integer)
          required(:cost).filled(:float)
        end
      end
    end
  end
end