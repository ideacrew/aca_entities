# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    module Contracts
      # contract for EvidenceContract
      class EvidenceContract < Dry::Validation::Contract
        params do
          required(:key).filled(:symbol)
          required(:title).filled(:string)
          optional(:description).maybe(:string)
          optional(:evidence_items).array(
            AcaEntities::Eligibilities::EvidenceItem.params
          )
        end
      end
    end
  end
end
