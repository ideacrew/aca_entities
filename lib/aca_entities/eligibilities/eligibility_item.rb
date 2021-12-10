# frozen_string_literal: true

module AcaEntities
  # All types Eligibilities
  module Eligibilities
    # Reference to an class or other object type instance
    class EligibilityItem < Dry::Struct
      attribute :id, Types::String.meta(ommittable: true)
      attribute :key, Types::Coercible::String.meta(omittable: false)
      attribute :title, Types::String.meta(omittable: false)
      attribute :description, Types::String.optional.meta(omittable: true)
      attribute :evidence_items,
                Array
                  .of(AcaEntities::Eligibilities::EvidenceItem)
                  .meta(ommittable: true)
    end
  end
end
