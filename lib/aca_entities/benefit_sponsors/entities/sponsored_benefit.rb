# frozen_string_literal: true

module AcaEntities
  module BenefitSponsors
    class SponsoredBenefit < Dry::Struct
      transform_keys(&:to_sym)

      attribute :product_package_kind,        Types::Strict::Symbol
      attribute :product_option_choice,       Types::Strict::String
      attribute :source_kind,                 Types::Strict::Symbol

      attribute :reference_product,           ::BenefitMarkets::Entities::Product
      attribute :sponsor_contribution,        BenefitSponsors::SponsorContribution
      attribute :pricing_determinations,      Types::Array.of(BenefitSponsors::PricingDetermination)
    end
  end
end