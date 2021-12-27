# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    module Contracts
      # contract for EvidenceContract
      class DeterminationContract < Dry::Validation::Contract

        params do
          required(:effective_date).filled(type?: Date)
          required(:subjects).value(:hash)
        end

        rule(:subjects) do
          values.to_h[:subjects].each_pair do |subject_key, subject_val|
            result =
              AcaEntities::Eligibilities::Contracts::SubjectContract.new.call(
                subject_val
              )
            next unless result.failure?

            key([*path, subject_key]).failure(
              { text: 'error', code: result.errors.to_h }
            )
          end
        end
      end
    end
  end
end
