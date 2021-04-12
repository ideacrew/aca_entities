# frozen_string_literal: true

# rubocop:disable all

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Configuration values and shared rules and macros for {AcaEntities::Medicaid} validation contracts
      class Contract < Dry::Validation::Contract
        include AcaEntities::AppHelper
        # config.messages.backend - the localization backend to use. Supported values are: :yaml and :i18n
        # config.messages.backend = :i18n
        # config.messages.default_locale - default I18n-compatible locale identifier
        # config.messages.default_locale = :en
        # config.messages.load_paths - an array of files paths that are used to load messages
        # config.messages.top_namespace - the key in the locale files under which messages are defined, by default it's dry_validation
        # config.messages.namespace - custom messages namespace for a contract class. Use this to differentiate common messages

        rule(:aptc_effective_end_on, :aptc_effective_start_on) do
          key.failure('must be after aptc_effective_start_on') if key? && values[:aptc_effective_end_on] < values[:aptc_effective_start_on]
        end

        rule(:applicants) do
          key.failure(text: 'at least one applicant must be present') if key? && check_if_blank?(value)
        end

        def any_income?(applicant_hash)
          applicant_hash[:has_job_income] || applicant_hash[:has_self_employment_income] || applicant_hash[:has_unemployment_income] || applicant_hash[:has_other_income]
        end

        def any_benefit?(applicant_hash)
          applicant_hash[:has_enrolled_health_coverage] || applicant_hash[:has_eligible_health_coverage]
        end

        def benefit_kind_esi?(kind_value)
          kind_value == 'employer_sponsored_insurance'
        end

        def benefit_status_enrolled?(status_value)
          status_value == 'is_enrolled'
        end

        def applicant_age(dob)
          now = Time.now.utc.to_date
          now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
        end

        rule(:applicants).each do |index:|
          if key?
            if value[:is_required_to_file_taxes] && check_if_blank?(value[:is_claimed_as_tax_dependent])
              key([:applicants, index, :is_claimed_as_tax_dependent]).failure(text: 'must be answered when is_required_to_file_taxes is true')
            end

            # Attestation
            if value[:is_applying_coverage] && check_if_blank?(value[:attestation][:is_incarcerated])
              key([:applicants, index, :attestation, :is_incarcerated]).failure(text: 'cannot be blank when is_applying_coverage is true')
            end

            # Benefits
            if any_benefit?(value) && check_if_blank?(value[:benefits])
              key([:applicants, index, :benefits]).failure(text: 'at least one benefit should be present if has_enrolled_health_coverage or has_eligible_health_coverage is true')
            end

            value[:benefits].each_with_index do |benefit, b_index|
              failure_key = [:applicants, index, :benefits, b_index]

              if check_if_present?(benefit[:employer]) && check_if_present?(benefit[:employer][:employer_id]) && !benefit[:employer][:employer_id].match?(/^[0-9]$/)
                key(failure_key + [:employer, :employer_id]).failure(text: 'must be numbers only')
              end

              if benefit_kind_esi?(benefit[:kind])
                # employer
                if check_if_blank?(benefit[:employer])
                  key(failure_key + [:employer]).failure(text: 'cannot be blank if benefit kind is employer_sponsored_insurance')
                end

                # esi_covered
                if check_if_blank?(benefit[:esi_covered])
                  key(failure_key + [:esi_covered]).failure(text: 'is expected when benefit kind is employer_sponsored_insurance')
                end

                # employee_cost_frequency
                if check_if_blank?(benefit[:employee_cost_frequency])
                  key(failure_key + [:employee_cost_frequency]).failure(text: 'is expected when benefit kind is employer_sponsored_insurance')
                end

                # employee_cost
                if check_if_blank?(benefit[:employee_cost])
                  key(failure_key + [:employee_cost]).failure(text: 'is expected when benefit kind is employer_sponsored_insurance')
                end
              end

              # end_on
              if check_if_present?(benefit[:end_on]) && benefit[:start_on] && benefit[:end_on] < benefit[:start_on]
                key(failure_key + [:end_on]).failure(text: 'must be after benefit start_on')
              end

              if (benefit_kind_esi?(benefit[:kind]) || benefit_status_enrolled?(benefit[:status])) && check_if_blank?(benefit[:start_on])
                key(failure_key + [:start_on]).failure(text: 'is expected when benefit kind is employer_sponsored_insurance or status is is_enrolled')
              end

            end if check_if_present?(value[:benefits]) && value[:benefits].is_a?(Array)

            # Deductions
            if value[:has_deductions] && check_if_blank?(value[:deductions])
              key([:applicants, index, :deductions]).failure(text: 'at least one deduction should be present if has_deductions is true')
            end

            value[:deductions].each_with_index do |deduction, d_index|
              # end_on
              if check_if_present?(deduction[:end_on]) && deduction[:start_on] && deduction[:end_on] < deduction[:start_on]
                key([:applicants, index, :deductions, d_index, :end_on]).failure(text: 'must be after deduction start_on')
              end
            end if check_if_present?(value[:deductions]) && value[:deductions].is_a?(Array)

            # Demographic
            if value[:is_applying_coverage] && check_if_blank?(value[:demographic][:is_veteran_or_active_military])
              key([:applicants, index, :demographic, :is_veteran_or_active_military]).failure(text: 'cannot be blank when is_applying_coverage is true')
            end

            age_of_applicant = applicant_age(value[:demographic][:dob])

            # FosterCare
            foster_care = value[:foster_care]
            foster_failure_key = [:applicants, index, :foster_care]
            if Types::FosterCareRange.cover?(age_of_applicant)
              if check_if_blank?(foster_care[:is_former_foster_care])
                key(foster_failure_key + [:is_former_foster_care]).failure(text: "must be filled if age of applicant is within #{Types::FosterCareRange}")
              end

              if foster_care[:is_former_foster_care]
                if check_if_blank?(foster_care[:age_left_foster_care])
                  key(foster_failure_key + [:age_left_foster_care]).failure(text: "must be filled if age of applicant is within #{Types::FosterCareRange}")
                end

                if check_if_blank?(foster_care[:foster_care_us_state])
                  key(foster_failure_key + [:foster_care_us_state]).failure(text: "must be filled if age of applicant is within #{Types::FosterCareRange}")
                end

                if check_if_blank?(foster_care[:had_medicaid_during_foster_care])
                  key(foster_failure_key + [:had_medicaid_during_foster_care]).failure(text: "must be filled if age of applicant is within #{Types::FosterCareRange}")
                end
              end
            end

            # Incomes
            if any_income?(value) && check_if_blank?(value[:incomes])
              key([:applicants, index, :incomes]).failure(text: 'at least one income should be present if has_job_income or has_self_employment_income or has_unemployment_income or has_other_income is true')
            end

            value[:incomes].each_with_index do |income, i_index|
              income_failure_key = [:applicants, index, :incomes, i_index]
              if check_if_present?(income[:employer]) &&
                 check_if_present?(income[:employer][:employer_id]) &&
                 !income[:employer][:employer_id].match?(/^[0-9]$/)
                key(income_failure_key + [:employer, :employer_id]).failure(text: 'must be numbers only')
              end

              # end_on
              if check_if_present?(income[:end_on]) && income[:start_on] && income[:end_on] < income[:start_on]
                key([:applicants, index, :incomes, i_index, :end_on]).failure(text: 'must be after income start_on')
              end
            end if check_if_present?(value[:incomes]) && value[:incomes].is_a?(Array)

            if check_if_present?(value[:native_american_information]) &&
               check_if_present?(value[:native_american_information][:tribal_id]) &&
               !value[:native_american_information][:tribal_id].match?(/^[0-9]$/)
              key([:applicants, index, :native_american_information, :tribal_id]).failure(text: 'must be numbers only')
            end

            # PregnancyInformation
            pregnancy = value[:pregnancy_information]
            pregnancy_failure_key = [:applicants, index, :pregnancy_information]

            if pregnancy[:is_pregnant] == false
              if check_if_blank?(pregnancy[:is_post_partum_period])
                key(pregnancy_failure_key + [:is_post_partum_period]).failure(text: 'must be filled if the applicant is not pregnant')
              end

              if pregnancy[:is_post_partum_period] && check_if_blank?(pregnancy[:pregnancy_end_on])
                key(pregnancy_failure_key + [:pregnancy_end_on]).failure(text: 'must be filled if the applicant is not pregnant')

                if value[:is_applying_coverage]
                  error_text = 'must be filled if the applicant is not applying for coverage, not pregnant and is in post partum period'
                  key(pregnancy_failure_key + [:is_enrolled_on_medicaid]).failure(text: error_text)
                end
              end
            elsif pregnancy[:is_pregnant]
              if check_if_blank?(pregnancy[:expected_children_count])
                key(pregnancy_failure_key + [:expected_children_count]).failure(text: 'must be filled if the applicant is pregnant')
              end

              if check_if_blank?(pregnancy[:pregnancy_due_on])
                key(pregnancy_failure_key + [:pregnancy_due_on]).failure(text: 'must be filled if the applicant is pregnant')
              end
            end

            # Student
            student = value[:student]
            student_failure_key = [:applicants, index, :student]

            if Types::StudentRange.cover?(age_of_applicant)
              err_text = "must be filled if age of applicant is within #{Types::StudentRange}."
              key(student_failure_key + [:is_student]).failure(text: err_text) if check_if_blank?(student[:is_student])

              if student[:is_student]
                key(student_failure_key + [:student_kind]).failure(text: err_text) if check_if_blank?(student[:student_kind])

                key(student_failure_key + [:student_school_kind]).failure(text: err_text) if check_if_blank?(student[:student_school_kind])
              end
            end
          end
        end
      end
    end
  end
end

# rubocop:enable all
