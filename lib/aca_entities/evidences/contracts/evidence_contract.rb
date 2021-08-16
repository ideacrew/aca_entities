# frozen_string_literal: true

module AcaEntities
  module Evidences
    # contract for EvidenceContract
    class EvidenceContract < Dry::Validation::Contract
      params do
        required(:key).filled(:symbol)
        required(:required).filled(:string)
        optional(:description).maybe(:string)
        required(:eligibility_status).maybe(:string)
        optional(:due_on).maybe(:date)
        optional(:updated_by).maybe(:string)
        optional(:verification_status).maybe(AcaEntities::Evidences::VerificationStatusContract.params)
        optional(:verification_history).array(AcaEntities::Evidences::VerificationHistoryContract.params)
        optional(:eligibility_determinations).array(AcaEntities::Evidences::EligibilityDeterminationContract.params)
      end
    end
  end
end