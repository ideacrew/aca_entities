# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Mitc
      module Contracts
        # Contract for Household.
        class HouseholdContract < Dry::Validation::Contract

          params do
            required(:household_id).filled(:string)
            required(:people).array(:hash)
          end

          rule(:people) do
            if key? && value
              people_array = value.inject([]) do |hash_array, person_reference_hash|
                if person_reference_hash.is_a?(Hash)
                  result = PersonReferenceContract.new.call(person_reference_hash)
                  if result&.failure?
                    key.failure(text: 'invalid person reference.', error: result.errors.to_h)
                  else
                    hash_array << result.to_h
                  end
                else
                  key.failure(text: 'invalid person reference. Expected a hash.')
                end
                hash_array
              end
              values.merge!(people: people_array)
            end
          end
        end
      end
    end
  end
end
