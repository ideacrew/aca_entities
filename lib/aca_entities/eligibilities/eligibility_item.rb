# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    # An Eligibility definition
    class EligibilityItem < Dry::Struct
      include Dry::Monads[:result, :do, :try]

      attribute? :id, Types::Coercible::String.optional.meta(ommittable: true)
      attribute :key, Types::Coercible::String.meta(omittable: false)
      attribute? :title, Types::Coercible::String.optional.meta(omittable: true)
      attribute? :description,
                 Types::Coercible::String.optional.meta(omittable: true)
      attribute :evidence_items,
                Types::Array
                  .of(AcaEntities::Eligibilities::EvidenceItem)
                  .meta(ommittable: false)
      attribute? :tags,
                 Types::Array
                   .of(Types::Coercible::String)
                   .optional
                   .meta(ommittable: true)
      attribute? :published_at, Types::DateTime.optional.meta(ommittable: true)
    end
  end
end
