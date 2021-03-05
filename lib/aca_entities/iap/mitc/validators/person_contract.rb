# frozen_string_literal: true

module AcaEntities
  module Iap
    module Mitc
      module Validators
        # Contract for Person.
        class PersonContract < Dry::Validation::Contract

          params do
            required(:person_id).filled(:integer)
            required(:is_applicant).filled(Types::YesNoKind)
            required(:is_blind_or_disabled).filled(Types::YesNoKind)
            required(:is_full_time_student).filled(Types::YesNoKind)
            required(:is_medicare_entitled).filled(Types::YesNoKind)
            required(:is_incarcerated).filled(Types::YesNoKind)
            required(:is_claimed_as_dependent_by_non_applicant).filled(Types::YesNoKind)
            required(:is_self_attested_long_term_care).filled(Types::YesNoKind)
            required(:has_insurance).filled(Types::YesNoKind)
            required(:has_state_health_benefit).filled(Types::YesNoKind)
            required(:had_prior_insurance).filled(Types::YesNoKind)
            optional(:prior_insurance_end_date).maybe(:date)
            required(:is_pregnant).filled(Types::YesNoKind)
            optional(:children_expected_count).maybe(:integer)
            optional(:is_in_post_partum_period).maybe(Types::YesNoKind)
            required(:is_in_former_foster_care).filled(Types::YesNoKind)
            optional(:had_medicaid_during_foster_care).maybe(Types::YesNoKind)
            optional(:age_left_foster_care).maybe(:integer)
            optional(:foster_care_us_state).maybe(::AcaEntities::Types::UsStateAbbreviationKind)
            required(:is_required_to_file_taxes).filled(Types::YesNoKind)
            required(:age_of_applicant).filled(:integer)
            required(:hours_worked_per_week).filled(:integer)
            required(:is_temporarily_out_of_state).filled(Types::YesNoKind)
            required(:is_us_citizen).filled(Types::YesNoKind)
            required(:is_lawful_presence_self_attested).filled(Types::YesNoKind)
            optional(:immigration_status).maybe(Types::ImmigrationStatusKind)
            optional(:is_amerasian).maybe(Types::YesNoKind)
            optional(:has_forty_title_ii_work_quarters).maybe(Types::YesNoKind)
            optional(:five_year_bar_applies).maybe(Types::YesNoKind)
            optional(:is_five_year_bar_met).maybe(Types::YesNoKind)
            required(:is_trafficking_victim).filled(Types::YesNoKind)
            required(:is_eligible_for_refugee_medical_assistance).filled(Types::YesNoKind)
            optional(:refugee_medical_assistance_start_date).maybe(Types::Date)
            optional(:seven_year_limit_start_date).maybe(Types::Date)
            required(:is_veteran).filled(Types::YesNoKind)
            required(:income).filled(:hash)
            required(:relationships).array(:hash)
          end

          rule(:prior_insurance_end_date) do
            key.failure('cannot be empty.') if values[:had_prior_insurance] == 'Y' && value.nil?
          end

          rule(:children_expected_count) do
            key.failure('cannot be empty.') if values[:is_pregnant] == 'Y' && value.nil?
          end

          rule(:is_in_post_partum_period) do
            key.failure('cannot be empty.') if values[:is_pregnant] == 'Y' && value.nil?
          end

          rule(:had_medicaid_during_foster_care) do
            key.failure('cannot be empty.') if values[:is_in_former_foster_care] == 'Y' && value.nil?
          end

          rule(:age_left_foster_care) do
            key.failure('cannot be empty.') if values[:is_in_former_foster_care] == 'Y' && value.nil?
          end

          rule(:foster_care_us_state) do
            key.failure('cannot be empty.') if values[:is_in_former_foster_care] == 'Y' && value.nil?
          end

          rule(:immigration_status) do
            key.failure('cannot be empty.') if values[:is_lawful_presence_self_attested] == 'Y' && value.nil?
          end

          rule(:is_amerasian) do
            key.failure('cannot be empty.') if values[:is_lawful_presence_self_attested] == 'Y' && value.nil?
          end

          rule(:has_forty_title_ii_work_quarters) do
            key.failure('cannot be empty.') if values[:is_lawful_presence_self_attested] == 'Y' && value.nil?
          end

          rule(:five_year_bar_applies) do
            key.failure('cannot be empty.') if values[:is_lawful_presence_self_attested] == 'Y' && value.nil?
          end

          rule(:is_five_year_bar_met) do
            if values[:is_lawful_presence_self_attested] == 'Y' && values[:five_year_bar_applies] == 'Y' && value.nil?
              key.failure('cannot be empty.')
            end
          end

          rule(:refugee_medical_assistance_start_date) do
            key.failure('cannot be empty.') if values[:is_eligible_for_refugee_medical_assistance] == 'Y' && value.nil?
          end

          rule(:seven_year_limit_start_date) do
            key.failure('cannot be empty.') if values[:is_eligible_for_refugee_medical_assistance] == 'Y' && value.nil?
          end

          rule(:income) do
            if key? && value
              if value.is_a?(Hash)
                result = IncomeContract.new.call(value)
                if result&.failure?
                  key.failure(text: 'invalid income', error: result.errors.to_h)
                else
                  values.merge!(income: result.to_h)
                end
              else
                key.failure(text: 'invalid income. Expected a hash.')
              end
            end
          end

          rule(:relationships) do
            if key? && value
              relationships_array = value.inject([]) do |hash_array, relationship_hash|
                if relationship_hash.is_a?(Hash)
                  result = RelationshipContract.new.call(relationship_hash)
                  if result&.failure?
                    key.failure(text: 'invalid relationship.', error: result.errors.to_h)
                  else
                    hash_array << result.to_h
                  end
                else
                  key.failure(text: 'invalid relationship. Expected a hash.')
                end
                hash_array
              end
              values.merge!(relationships: relationships_array)
            end
          end
        end
      end
    end
  end
end
