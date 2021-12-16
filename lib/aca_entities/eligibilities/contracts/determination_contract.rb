# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    module Contracts
      # contract for EvidenceContract
      class DeterminationContract < Dry::Validation::Contract
        params do
          required(:status).filled(
            AcaEntities::Eligibilities::Types::DeterminationStateKind
          )
          required(:earliest_due_date).filled(:date)
          required(:determined_at).filled(:date_time)
          required(:evidence_states).value(:hash)
        end

        rule(:evidence_states) do
          values.to_h[:evidence_states]
            .each_pair do |evidence_state_key, evidence_state_val|
            result =
              AcaEntities::Eligibilities::Contracts::EvidenceStateContract.new
                .call(evidence_state_val)
            next unless result.failure?

            key([*path, evidence_state_key]).failure(
              { text: 'error', code: result.errors.to_h }
            )
          end
        end
      end
    end
  end
end
