# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    # Entity for benefirmarkets ContributionModel
    class ContributionModel < Dry::Struct

      attribute :title,                                 Types::Strict::String.meta(omittable: false)
      attribute :key,                                   Types::Symbol.optional.meta(omittable: true)
      attribute :sponsor_contribution_kind,             Types::Strict::String.meta(omittable: false)
      attribute :contribution_calculator_kind,          Types::Strict::String.meta(omittable: false)
      attribute :many_simultaneous_contribution_units,  Types::Strict::Bool.meta(omittable: false)
      attribute :product_multiplicities,                Types::Strict::Array.meta(omittable: false)
      attribute :contribution_units,                    Types::Array.of(BenefitMarkets::ContributionUnit).meta(omittable: false)
      attribute :member_relationships,                  Types::Array.of(BenefitMarkets::MemberRelationship).meta(omittable: false)

    end
  end
end