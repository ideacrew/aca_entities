# frozen_string_literal: true

module AcaEntities
  # All types Eligibilities
  module Eligibilities
    class EvidenceState < Dry::Struct
      attribute :evidence_gid,
                Types::Coercible::String.optional.meta(omittable: false)
      attribute :status,
                AcaEntities::Eligibilities::Types::EvidenceStateKind.meta(
                  ommittable: false
                )
      attribute :is_satisfied, Types::Bool.meta(ommittable: false)
      attribute :verification_outstanding, Types::Bool.meta(ommittable: false)
      attribute :due_on, Types::Date.meta(ommittable: false)
      attribute :visited_at, Types::DateTime.meta(ommittable: false)
      attribute? :meta, Types::Hash.meta(ommittable: true)
    end
  end
end
