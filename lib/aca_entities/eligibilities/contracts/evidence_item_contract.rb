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
          required(:subject_ref).value(type?: URI)
          required(:evidence_ref).value(type?: URI)
        end
      end
    end
  end
end
