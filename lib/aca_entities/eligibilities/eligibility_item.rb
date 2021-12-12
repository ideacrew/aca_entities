# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    # An Eligibility definition
    class EligibilityItem < Dry::Struct
      attribute :id, Types::String.meta(ommittable: true)
      attribute :key, Types::Coercible::String.meta(omittable: false)
      attribute :title, Types::String.meta(omittable: true)
      attribute :description, Types::String.optional.meta(omittable: true)
      attribute :evidence_items, Types::Array.of(AcaEntities::Eligibilities::EvidenceItem).meta(ommittable: true)

      # @!attribute [r] marketplaces
      # The Enroll App marketplaces where this Eligibility is used
      # @return [Array<String>]
      attribute :marketplaces, Types::String.meta(ommittable: true)
      attribute :tags, Types::String.meta(ommittable: true)
      # attribute :workflow
      # attribute :status
      # attribute :published_at
    end
  end
end
