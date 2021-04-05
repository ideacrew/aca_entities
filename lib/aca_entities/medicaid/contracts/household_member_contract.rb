# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for HouseholdMember.
      class HouseholdMemberContract < Dry::Validation::Contract
        params do
          required(:person_name).filled(:hash)
          optional(:identifying_information).maybe(:hash)
          required(:demographic).filled(:hash)
          optional(:pregnancy_information).maybe(:hash)
          optional(:current_income_information).filled(:hash)
          optional(:current_deduction_information).filled(:hash)
          optional(:current_income).filled(:hash)
          optional(:current_income_employer).filled(:hash)
          optional(:pay_period_information).filled(:hash)
          optional(:relationships).filled(:array)
        end

        rule(:person_name) do
          if key? && value
            if value.is_a?(Hash)
              result = PersonNameContract.new.call(value)
              if result&.failure?
                key.failure(text: 'invalid person name', error: result.errors.to_h)
              else
                values.merge!(person_name: result.to_h)
              end
            else
              key.failure(text: 'invalid person name. Expected a hash.')
            end
          end
        end

        rule(:identifying_information) do
          if key? && value
            if value.is_a?(Hash)
              result = IdentifyingInformationContract.new.call(value)
              if result&.failure?
                key.failure(text: 'invalid identifying_information', error: result.errors.to_h)
              else
                values.merge!(identifying_information: result.to_h)
              end
            else
              key.failure(text: 'invalid identifying_information. Expected a hash.')
            end
          end
        end

        rule(:demographic) do
          if key? && value
            if value.is_a?(Hash)
              result = DemographicContract.new.call(value)
              if result&.failure?
                key.failure(text: 'invalid demographic information', error: result.errors.to_h)
              else
                values.merge!(demographic: result.to_h)
              end
            else
              key.failure(text: 'invalid demographic information. Expected a hash.')
            end
          end
        end

        rule(:pregnancy_information) do
          if key? && value
            if value.is_a?(Hash)
              result = PregnancyInformationContract.new.call(value)
              if result&.failure?
                key.failure(text: 'invalid pregnancy_information', error: result.errors.to_h)
              else
                values.merge!(pregnancy_information: result.to_h)
              end
            else
              key.failure(text: 'invalid pregnancy_information. Expected a hash.')
            end
          end
        end

        rule(:current_income_information) do
          if key? && value
            if value.is_a?(Hash)
              result = CurrentIncomeInformationContract.new.call(value)
              if result&.failure?
                key.failure(text: 'invalid current_income_information', error: result.errors.to_h)
              else
                values.merge!(current_income_information: result.to_h)
              end
            else
              key.failure(text: 'invalid current_income_information. Expected a hash.')
            end
          end
        end

        rule(:current_deduction_information) do
          if key? && value
            if value.is_a?(Hash)
              result = CurrentDeductionInformationContract.new.call(value)
              if result&.failure?
                key.failure(text: 'invalid current_deduction_information', error: result.errors.to_h)
              else
                values.merge!(current_deduction_information: result.to_h)
              end
            else
              key.failure(text: 'invalid current_deduction_information. Expected a hash.')
            end
          end
        end

        rule(:current_income) do
          if key? && value
            if value.is_a?(Hash)
              result = CurrentIncomeContract.new.call(value)
              if result&.failure?
                key.failure(text: 'invalid current_income', error: result.errors.to_h)
              else
                values.merge!(current_income: result.to_h)
              end
            else
              key.failure(text: 'invalid current_income. Expected a hash.')
            end
          end
        end

        rule(:current_income_employer) do
          if key? && value
            if value.is_a?(Hash)
              result = CurrentIncomeEmployerContract.new.call(value)
              if result&.failure?
                key.failure(text: 'invalid current_income_employer', error: result.errors.to_h)
              else
                values.merge!(current_income_employer: result.to_h)
              end
            else
              key.failure(text: 'invalid current_income_employer. Expected a hash.')
            end
          end
        end

        rule(:pay_period_information) do
          if key? && value
            if value.is_a?(Hash)
              result = PayPeriodInformationContract.new.call(value)
              if result&.failure?
                key.failure(text: 'invalid pay_period_information', error: result.errors.to_h)
              else
                values.merge!(pay_period_information: result.to_h)
              end
            else
              key.failure(text: 'invalid pay_period_information. Expected a hash.')
            end
          end
        end

        rule(:relationships) do
          if key? && value
            infd_array = value.inject([]) do |hash_array, relationship_hash|
              if relationship_hash.is_a?(Hash)
                result = RelationshipContract.new.call(relationship_hash)
                if result&.failure?
                  key.failure(text: 'invalid relationships.', error: result.errors.to_h)
                else
                  hash_array << result.to_h
                end
              else
                key.failure(text: 'invalid relationships. Expected a hash.')
              end
              hash_array
            end
            values.merge!(relationships: infd_array)
          end
        end
      end
    end
  end
end
