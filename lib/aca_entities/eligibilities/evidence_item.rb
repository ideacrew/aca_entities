# frozen_string_literal: true

module AcaEntities
  # All types Eligibilities
  module Eligibilities
    # Reference to an class or other object type instance
    class EvidenceItem < Dry::Struct
      attribute :id, Types::String.meta(ommittable: true)
      attribute :key, Types::Coercible::String.meta(omittable: false)
      attribute :title, Types::String.meta(omittable: true)
      attribute :description, Types::String.optional.meta(omittable: true)
      attribute :subject_ref, Types::String.optional.meta(omittable: false)
      attribute :evidence_ref, Types::String.optional.meta(omittable: false)
    end
  end
end
