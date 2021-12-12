# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    module Contracts
      # contract for EvidenceContract
      class DeterminationContract < Dry::Validation::Contract
        EligibilitySchema =
          Dry::Schema.Params do
            required(:status).filled(AcaEntities::Eligibilities::Types::DeterminationStateKind)
            required(:earliest_due_date).filled(:date)
            required(:determined_at).filled(:date_time)
            required(:evidence_states).value(:hash)
          end

        rule(:evidence_states).each do
          values
            .to_h
            .slice(:evidence_states)
            .each_pair do |evidence_state_key, evidence_state_val|
              result = EligibilitySchema.call(evidence_state_val)
              result.errors.to_h.each { |path, message| key([:determinations, *path]).failure(message) } if result.failure?
            end
        end

        params { required(:determinations).value(:hash) }

        rule(:determinations).each do
          values.to_h[:determinations].each_pair do |eligibility_key, eligibility_val|
            result = EligibilitySchema.call(eligibility_val)
            result.errors.to_h.each { |path, message| key([:determinations, *path]).failure(message) } if result.failure?
          end
        end
      end
    end
  end
end
