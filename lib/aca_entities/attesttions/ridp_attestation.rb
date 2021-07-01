# frozen_string_literal: true

module AcaEntities
  module Attestations
    class RidpAttestation < Dry::Stuct
      attribute :is_satisfied?, Types::Bool.optional.meta(omittable: false)
      attribute :is_self_attested?, Types::Bool.optional.meta(omittable: false)
      attribute :satisfied_at, Types::DateTime.optional.meta(omittable: true)
      attribute :documents,
                Types::Array
                  .of(AcaEntities::Documents::RidpDocument)
                  .meta(omittable: false)

      attribute :evidences,
                Types::Array
                  .of(AcaEntities::Evidences::RidpEvidence)
                  .meta(omittable: true)

      attribute :status,
                AcaEntties::Types::Attestations::RidpStatusKind.optional.meta(
                  omittable: false
                )

      attribute :workflow_state_transitions
    end
  end
end