# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    module Contracts
      # contract for EvidenceContract
      class EvidenceContract < Dry::Validation::Contract
        params do
          optional(:key).filled(:symbol)
          required(:title).filled(:string)
          optional(:aasm_state).maybe(:string)

          optional(:description).maybe(:string)
          optional(:received_at).maybe(:date_time)

          optional(:is_satisfied).maybe(:bool)
          optional(:verification_outstanding).maybe(:bool)

          optional(:update_reason).maybe(:string)
          optional(:due_on).maybe(:date)
          optional(:external_service).maybe(:string)
          optional(:updated_by).maybe(:string)

          optional(:evidence_items).array(AcaEntities::Eligibilities::Contracts::EvidenceItemContract.params)
          optional(:verification_histories).array(AcaEntities::Eligibilities::Contracts::VerificationHistoryContract.params)
          optional(:request_results).array(AcaEntities::Eligibilities::Contracts::RequestResultContract.params)
        end
      end
    end
  end
end
