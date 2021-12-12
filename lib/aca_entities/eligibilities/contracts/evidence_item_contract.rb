# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    module Contracts
      # contract for EvidenceContract
      class EvidenceItemContract < Dry::Validation::Contract
        params do
          optional(:id).maybe(:string)
          required(:key).filled(:string)
          optional(:title).maybe(:string)
          optional(:description).maybe(:string)
          required(:subject_ref).maybe(:string)
          required(:evidence_ref).maybe(:string)
        end
      end
    end
  end
end
