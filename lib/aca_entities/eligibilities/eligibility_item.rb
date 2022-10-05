# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    # The definition of a right conveyed to a system actor to do or obtain something
    #   provided certain conditions are met.
    class EligibilityItem < Dry::Struct
      include Dry::Monads[:result, :do, :try]

      # include AcaEntities::Operations::Mongoid::ModelAdapter

      # persistence_model_name 'Eligibilities::EligibilityItem'

      attribute? :id, Types::Coercible::String.optional.meta(ommittable: true)
      attribute :key, Types::Coercible::String.meta(omittable: false)
      attribute? :title, Types::Coercible::String.optional.meta(omittable: true)
      attribute? :description, Types::Coercible::String.optional.meta(omittable: true)
      attribute :evidence_items, Types::Array.of(AcaEntities::Eligibilities::EvidenceItem).meta(ommittable: false)
      attribute? :tags, Types::Array.of(Types::Coercible::String).optional.meta(ommittable: true)
      attribute? :published_at, Types::DateTime.optional.meta(ommittable: true)
    end
  end
end
