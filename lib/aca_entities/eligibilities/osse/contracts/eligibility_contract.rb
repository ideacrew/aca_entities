# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    module Osse
      module Contracts
        # contract for eligibilies
        class EligibilityContract < Dry::Validation::Contract
          params do
            required(:subject).filled(AcaEntities::Eligibilities::Osse::Contracts::SubjectContract.params)
            optional(:status).maybe(:string)
            optional(:evidences).array(AcaEntities::Eligibilities::Contracts::EvidenceItemContract.params)
            optional(:grants).array(AcaEntities::Eligibilities::Osse::Contracts::GrantContract.params)
            required(:start_on).filled(type?: Date)
            optional(:end_on).filled(type?: Date)
          end

          # rule(:subjects) do
          #   values.to_h[:subjects].each_pair do |subject_key, subject_val|
          #     result =
          #       AcaEntities::Eligibilities::Contracts::SubjectContract.new.call(
          #         subject_val
          #       )
          #     next unless result.failure?

          #     key([*path, subject_key]).failure(
          #       { text: 'error', code: result.errors.to_h }
          #     )
          #   end
          # end
        end
      end
    end
  end
end
