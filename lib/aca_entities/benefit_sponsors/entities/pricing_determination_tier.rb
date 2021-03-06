# frozen_string_literal: true

module AcaEntities
  module BenefitSponsors
    class PricingDeterminationTier < Dry::Struct
      transform_keys(&:to_sym)

      attribute :pricing_unit_id,           Types::Strict::String
      attribute :price,                     Types::Strict::Float

    end
  end
end