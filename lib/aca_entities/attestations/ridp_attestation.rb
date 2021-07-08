# frozen_string_literal: true

module AcaEntities
  module Attestations
    # entity for RidpAttestation
    class RidpAttestation < Dry::Struct
      attribute :is_satisfied, Types::Bool.optional.meta(omittable: false)
      attribute :is_self_attested, Types::Bool.optional.meta(omittable: false)
      attribute :satisfied_at, Types::DateTime.optional.meta(omittable: true)
      attribute :documents,
                Types::Array
                  .of(AcaEntities::Documents::RidpDocument).optional.meta(omittable: true)

      attribute :evidences,
                Types::Array
                  .of(AcaEntities::Evidences::RidpEvidence)
                  .meta(omittable: true)

      attribute :status,
                Types::RidpStatusKind.optional.meta(
                  omittable: false
                )

      attribute :workflow_state_transitions,
                AcaEntities::Transitions::WorkflowStateTransition.optional.meta(omittable: true)
    end
  end
end
