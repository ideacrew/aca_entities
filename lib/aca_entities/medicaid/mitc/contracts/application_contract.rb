# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Mitc
      module Contracts
        # Contract for Application.
        class ApplicationContract < Dry::Validation::Contract

          params do
            required(:name).filled(Types::String)
            required(:state).filled(::AcaEntities::Types::UsStateAbbreviationKind)
            required(:application_year).filled(:integer)
            required(:people).array(:hash)
            required(:physical_households).array(:hash)
            required(:tax_returns).array(:hash)
          end

          rule(:people) do
            if key? && value
              people_array = value.inject([]) do |hash_array, person_hash|
                if person_hash.is_a?(Hash)
                  result = PersonContract.new.call(person_hash)
                  if result&.failure?
                    key.failure(text: 'invalid person.', error: result.errors.to_h)
                  else
                    hash_array << result.to_h
                  end
                else
                  key.failure(text: 'invalid person. Expected a hash.')
                end
                hash_array
              end
              values.merge!(people: people_array)
            end
          end

          rule(:physical_households) do
            if key? && value
              households_array = value.inject([]) do |hash_array, household_hash|
                if household_hash.is_a?(Hash)
                  result = HouseholdContract.new.call(household_hash)
                  if result&.failure?
                    key.failure(text: 'invalid household.', error: result.errors.to_h)
                  else
                    hash_array << result.to_h
                  end
                else
                  key.failure(text: 'invalid household. Expected a hash.')
                end
                hash_array
              end
              values.merge!(physical_households: households_array)
            end
          end

          rule(:tax_returns) do
            if key? && value
              tax_returns_array = value.inject([]) do |hash_array, tax_return_hash|
                if tax_return_hash.is_a?(Hash)
                  result = TaxReturnContract.new.call(tax_return_hash)
                  if result&.failure?
                    key.failure(text: 'invalid tax return.', error: result.errors.to_h)
                  else
                    hash_array << result.to_h
                  end
                else
                  key.failure(text: 'invalid tax return. Expected a hash.')
                end
                hash_array
              end
              values.merge!(tax_returns: tax_returns_array)
            end
          end
        end
      end
    end
  end
end
