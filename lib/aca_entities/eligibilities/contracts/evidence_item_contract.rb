# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    module Contracts
      # contract for EvidenceContract
      class EligibilityItemContract < Dry::Validation::Contract
        params do
          optional(:id).maybe(:string)
          required(:key).filled(:string)
          optional(:title).maybe(:string)
          optional(:description).maybe(:string)
          optional(:subject_ref).maybe(:string)
          optional(:evidence_ref).maybe(:string)
        end
      end
    end
  end
end
