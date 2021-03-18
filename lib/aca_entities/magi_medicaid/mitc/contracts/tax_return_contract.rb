# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Mitc
      module Contracts
        # Contract for TaxReturn
        class TaxReturnContract < Dry::Validation::Contract

          params do
            required(:filers).array(:hash)
            required(:dependents).array(:hash)
          end

          rule(:filers) do
            if key? && value
              filers_array = value.inject([]) do |hash_array, person_reference_hash|
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
              values.merge!(filers: filers_array)
            end
          end

          rule(:dependents) do
            if key? && value
              dependents_array = value.inject([]) do |hash_array, person_reference_hash|
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
              values.merge!(dependents: dependents_array)
            end
          end
        end
      end
    end
  end
end
