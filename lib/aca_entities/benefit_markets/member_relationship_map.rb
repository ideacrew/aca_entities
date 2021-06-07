# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    # Entity for benefirmarkets MemberRelationshipMap
    class MemberRelationshipMap < Dry::Struct

      attribute :relationship_name,     Types::Strict::Symbol.meta(omittable: false)
      attribute :operator,              Types::Strict::Symbol.meta(omittable: false)
      attribute :count,                 Types::Strict::Integer.meta(omittable: false)
    end
  end
end