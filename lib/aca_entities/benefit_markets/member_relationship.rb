# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    # Entity for benefirmarkets MemberRelationship
    class MemberRelationship < Dry::Struct

      attribute :relationship_name,         Types::Strict::Symbol.meta(omittable: false)
      attribute :relationship_kinds,        Types::Strict::Array.meta(omittable: false)

      attribute :age_threshold,             Types::Integer.optional.meta(omittable: true)
      attribute :age_comparison,            Types::Symbol.optional.meta(omittable: true)
      attribute :disability_qualifier,      Types::Bool.optional.meta(omittable: true)
    end
  end
end