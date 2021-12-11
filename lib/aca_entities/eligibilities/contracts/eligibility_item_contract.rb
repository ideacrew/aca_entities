# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    # contract for EvidenceContract
    class EligibilityItemContract < Dry::Validation::Contract
      params do
        required(:id).maybe(:string)
        required(:key).filled(:string)
        required(:title).maybe(:string)
        optional(:description).maybe(:string)
        optional(:evidence_items).array(
          AcaEntities::Eligibilities::Contracts::EvidenceItemContract.params
        )
      end
    end
  end
end
