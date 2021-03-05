# frozen_string_literal: true

module AcaEntities
  module Iap
    module Mitc
      module Validators
        # Contract for MedicaidHousehold
        class MedicaidHouseholdContract < Dry::Validation::Contract

          params do
            required(:people).array(:hash)
            required(:magi_income).filled(:integer)
            required(:size).filled(:integer)
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
