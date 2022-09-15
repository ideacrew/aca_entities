# frozen_string_literal: true

module AcaEntities
  # All types Eligibilities
  module Eligibilities
    class EvidenceState < Dry::Struct
      attribute :evidence_gid,
                Types::Coercible::String.optional.meta(omittable: false)
      attribute :status,
                AcaEntities::Eligibilities::Types::EvidenceStateKind.meta(
                  omittable: false
                )
      attribute :is_satisfied, Types::Bool.meta(omittable: false)
      attribute :verification_outstanding, Types::Bool.meta(omittable: false)
      attribute? :due_on, Types::Date.meta(omittable: true)
      attribute :visited_at, Types::DateTime.meta(omittable: false)
      attribute? :meta, Types::Hash.meta(omittable: true)

    end
  end
end
