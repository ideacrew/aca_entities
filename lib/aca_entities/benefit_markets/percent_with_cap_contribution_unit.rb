# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    # Entity for benefirmarkets MemberRelationship
    class PercentWithCapContributionUnit < BenefitMarkets::ContributionUnit

      attribute :default_contribution_factor,     Types::Strict::Float.meta(omittable: false)
      attribute :default_contribution_cap,        Types::Strict::Float.meta(omittable: false)
      attribute :minimum_contribution_factor,     Types::Strict::Float.meta(omittable: false)
    end
  end
end