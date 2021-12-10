# frozen_string_literal: true

module AcaEntities
  # All types Eligibilities
  module Eligibilities
    class EvidenceState < Dry::Struct
      attribute :id, Types::String.meta(ommittable: true)
      attribute :evidence_key, Types::String.meta(ommittable: false)

      # GlobalID URI
      atttibute :subject, Types::String.meta(ommittable: false)

      # GlobalID URI
      attribute :source, Types::String.meta(ommittable: false)

      attribute :is_satisfied, Types::Bool.meta(ommittable: false)
      attribute :verification_outstanding, Types::Bool.meta(ommittable: false)
      attribute :state,
                AcaEntities::Eligibilities::Types::EvidenceStateKind.meta(
                  ommittable: false
                )
      attribute :due_on, Types::Bool.meta(ommittable: false)

      attribute :visited_at, Types::DateTime.meta(ommittable: false)
    end
  end
end
