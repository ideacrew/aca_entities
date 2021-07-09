# frozen_string_literal: true

module AcaEntities
  module Attestations
    # Entity for RidpAttestation
    class RidpAttestationContract < Dry::Validation::Contract

      params do
        required(:is_satisfied).filled(:bool)
        required(:is_self_attested).filled(:bool)
        optional(:satisfied_at).maybe(:date_time)
        optional(:documents).array(AcaEntities::Contracts::Documents::RidpDocumentContract.params)

        optional(:evidences).array(AcaEntities::Evidences::RidpEvidenceContract.params)

        required(:status).filled(AcaEntities::Attestations::Types::RidpStatusKind)

        optional(:workflow_state_transitions).array(AcaEntities::Transitions::WorkflowStateTransitionContract.params)
      end
    end
  end
end
