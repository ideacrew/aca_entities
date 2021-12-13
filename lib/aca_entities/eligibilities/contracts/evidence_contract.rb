# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    module Contracts
      # contract for EvidenceContract
      class EvidenceContract < Dry::Validation::Contract
        params do
          required(:key).filled(:symbol)
          required(:title).filled(:string)
          required(:aasm_state).filled(:string)

          optional(:description).maybe(:string)
          optional(:received_at).maybe(:date_time)

          optional(:is_satisfied).maybe(:bool)
          optional(:verification_outstanding).maybe(:bool)

          optional(:update_reason).maybe(:string)
          optional(:due_on).maybe(:date)
          optional(:external_service).maybe(:string)
          optional(:updated_by).maybe(:string)

          optional(:evidence_items).array(AcaEntities::Eligibilities::Contracts::EvidenceItemContract.params)
          optional(:verification_history).array(AcaEntities::Eligibilities::Contracts::VerificationHistoryContract.params)
          optional(:eligibility_results).array(AcaEntities::Eligibilities::Contracts::RequestResultContract.params)
        end
      end
    end
  end
end