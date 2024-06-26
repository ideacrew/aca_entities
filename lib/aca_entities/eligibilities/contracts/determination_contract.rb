# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    module Contracts
      # contract for EvidenceContract
      class DeterminationContract < Dry::Validation::Contract
        params do
          required(:effective_date).filled(:date)
          required(:subjects).value(:hash)
          required(:outstanding_verification_status).filled(AcaEntities::Eligibilities::Types::DeterminationStateKind)
          required(:outstanding_verification_earliest_due_date).maybe(:date)
          required(:outstanding_verification_document_status).maybe(:string)
          optional(:grants).array(AcaEntities::Eligibilities::Contracts::GrantContract.params)
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
