# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    # contract for EvidenceContract
    class EligibilityItemContract < Dry::Validation::Contract
      params do
        optional(:id).maybe(:string)
        required(:key).filled(:string)
        optional(:title).maybe(:string)
        optional(:description).maybe(:string)
        required(:evidence_items).array(AcaEntities::Eligibilities::Contracts::EvidenceItemContract.params)
        optional(:tags).array(:string)
        optional(:published_at).maybe(:date_time)
      end
    end
  end
end
