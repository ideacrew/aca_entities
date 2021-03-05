# frozen_string_literal: true

module AcaEntities
  module Iap
    module Mitc
      module Validators
        # Contract for Applicant.
        class ApplicantContract < Dry::Validation::Contract

          params do
            required(:person_id).filled(:integer)
            required(:medicaid_household).filled(:hash)
            required(:is_medicaid_eligible).filled(Types::YesNoKind)
            required(:is_chip_eligible).filled(Types::YesNoKind)
            required(:medicaid_ineligibility_reasons).array(:string)
            required(:is_eligible_for_non_magi_reasons).filled(Types::YesNoKind)
            required(:chip_ineligibility_reasons).array(:string)
            required(:medicaid_category).filled(:string)
            required(:medicaid_category_threshold).filled(:integer)
            required(:physical_households).array(:hash)
            required(:chip_category).filled(:string)
            required(:chip_category_threshold).filled(:integer)
            required(:category_determination).filled(:hash)
            required(:qualified_children).array(:hash)
          end

          rule(:medicaid_household) do
            if key? && value
              if value.is_a?(Hash)
                result = HouseholdContract.new.call(value)
                if result&.failure?
                  key.failure(text: 'invalid medicaid_household.', error: result.errors.to_h)
                else
                  values.merge!(medicaid_household: result.to_h)
                end
              else
                key.failure(text: 'invalid medicaid_household. Expected a hash.')
              end
            end
          end

          rule(:physical_households) do
            if key? && value
              physical_households_array = value.inject([]) do |hash_array, household_hash|
                if household_hash.is_a?(Hash)
                  result = HouseholdContract.new.call(household_hash)
                  if result&.failure?
                    key.failure(text: 'invalid physical household.', error: result.errors.to_h)
                  else
                    hash_array << result.to_h
                  end
                else
                  key.failure(text: 'invalid physical household. Expected a hash.')
                end
                hash_array
              end
              values.merge!(physical_households: physical_households_array)
            end
          end

          rule(:qualified_children) do
            if key? && value
              qualified_children_array = value.inject([]) do |hash_array, child_hash|
                if child_hash.is_a?(Hash)
                  result = QualifiedChildContract.new.call(child_hash)
                  if result&.failure?
                    key.failure(text: 'invalid qualified child.', error: result.errors.to_h)
                  else
                    hash_array << result.to_h
                  end
                else
                  key.failure(text: 'invalid qualified child. Expected a hash.')
                end
                hash_array
              end
              values.merge!(qualified_children: qualified_children_array)
            end
          end
        end
      end
    end
  end
end
