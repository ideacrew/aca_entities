# frozen_string_literal: true

module AcaEntities
  module BenefitSponsors
    class PricingDetermination < Dry::Struct
      transform_keys(&:to_sym)

      attribute :group_size,                        Types::Strict::Integer
      attribute :participation_rate,                Types::Strict::Float

      attribute :pricing_determination_tiers,       Types::Array.of(BenefitSponsors::PricingDeterminationTier)
    end
  end
end