# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    module Contracts
      # Validation schema for EligibilityItem
      class EligibilityItemContract < Dry::Validation::Contract
        params do
          optional(:id).maybe(:string)
          required(:key).filled(:symbol)
          optional(:title).maybe(:string)
          optional(:description).maybe(:string)
          required(:evidence_items).array(
            AcaEntities::Eligibilities::Contracts::EvidenceItemContract.params
          )
          optional(:tags).array(:string)
          optional(:published_at).maybe(:date_time)
        end
      end
    end
  end
end
