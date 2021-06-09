# frozen_string_literal: true

module AcaEntities
  module Attestations
    # Entity for RidpAttestation
    class RidpAttestationContract < Dry::Validation::Contract

      required(:is_satisfied?).filed(:bool)
      required(:is_self_attested?).filed(:bool)
      optional(:satisfied_at).maybe(:date_time)
      required(:documents).filled(AcaEntities::Documents::RidpDocumentContract.params)

      optional(:evidences).array(AcaEntities::Evidences::RidpEvidenceContract.params)

      required(:status).filled(AcaEntities::Attestations::Types::RidpStatusKind)

      optional(:workflow_state_transitions).arrray(AcaEntities::Transitions::WorkflowStateTransitionsContract.params)

    end
  end
end
