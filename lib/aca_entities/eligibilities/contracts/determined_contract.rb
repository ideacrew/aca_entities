# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    module Contracts
      # contract for EvidenceContract
      class DeterminedContract < Dry::Validation::Contract
        params do
          required(:key).filled(:string)
          required(:status).filled(
            AcaEntities::Eligibilities::Types::DeterminationStatusKind
          )
          optional(:earliest_due_date).filled(:date)
          optional(:determined_at).filled(:date_time)
        end
      end
    end
  end
end
