# frozen_string_literal: true

module AcaEntities
  module Iap
    module Mitc
      module Validators
        class EligibilityResponseContract < Dry::Validation::Contract

          params do
            required(:determination_date).filled(:date)
            required(:applicants).array(:hash)
          end

          rule(:applicants) do
            if key? && value
              applicants_array = value.inject([]) do |hash_array, applicant_hash|
                                  if applicant_hash.is_a?(Hash)
                                    result = ApplicantContract.new.call(applicant_hash)
                                    if result&.failure?
                                      key.failure(text: 'invalid applicant.', error: result.errors.to_h)
                                    else
                                      hash_array << result.to_h
                                    end
                                  else
                                    key.failure(text: 'invalid applicant. Expected a hash.')
                                  end
                                  hash_array
                                end
              values.merge!(applicants: applicants_array)
            end
          end
        end
      end
    end
  end
end
