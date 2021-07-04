# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    # Entity for benefirmarkets ContributionUnit
    class ContributionUnit < Dry::Struct

      attribute :name,                      Types::Strict::String.meta(omittable: false)
      attribute :display_name,              Types::Strict::String.meta(omittable: false)
      attribute :order,                     Types::Strict::Integer.meta(omittable: false)
      attribute :member_relationship_maps,  Types::Array.of(BenefitMarkets::MemberRelationshipMap).meta(omittable: false)

    end
  end
end