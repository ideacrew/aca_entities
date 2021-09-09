# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Configuration values and shared rules and macros for {AcaEntities::MagiMedicaid} validation contracts
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
          applicant_hash[:has_job_income] ||
            applicant_hash[:has_self_employment_income] ||
            applicant_hash[:has_unemployment_income] ||
            applicant_hash[:has_other_income]
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
          next unless key?
          if value[:is_required_to_file_taxes] && check_if_blank?(value[:is_claimed_as_tax_dependent])
            key([:applicants, index, :is_claimed_as_tax_dependent]).failure(text: 'must be answered when is_required_to_file_taxes is true')
          end

          if value[:had_prior_insurance] && check_if_blank?(value[:prior_insurance_end_date])
            key([:applicants, index, :prior_insurance_end_date]).failure(text: 'cannot be blank when had_prior_insurance is true')
          end

          # Attestation
          if value[:is_applying_coverage] && check_if_blank?(value[:attestation][:is_incarcerated])
            key([:applicants, index, :attestation, :is_incarcerated]).failure(text: 'cannot be blank when is_applying_coverage is true')
          end

          # Benefits
          if any_benefit?(value) && check_if_blank?(value[:benefits])
            benefit_failure_err = 'at least one benefit should be present if has_enrolled_health_coverage or has_eligible_health_coverage is true'
            key([:applicants, index, :benefits]).failure(text: benefit_failure_err)
          end

          if check_if_present?(value[:benefits]) && value[:benefits].is_a?(Array)
            value[:benefits].each_with_index do |benefit, b_index|
              failure_key = [:applicants, index, :benefits, b_index]

              if check_if_present?(benefit[:employer]) &&
                 check_if_present?(benefit[:employer][:employer_id]) &&
                 !benefit[:employer][:employer_id].match?(/\A[0-9]+\Z/)
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
            end
          end

          # Deductions
          if value[:has_deductions] && check_if_blank?(value[:deductions])
            key([:applicants, index, :deductions]).failure(text: 'at least one deduction should be present if has_deductions is true')
          end

          if check_if_present?(value[:deductions]) && value[:deductions].is_a?(Array)
            value[:deductions].each_with_index do |deduction, d_index|
              # end_on
              if check_if_present?(deduction[:end_on]) && deduction[:start_on] && deduction[:end_on] < deduction[:start_on]
                key([:applicants, index, :deductions, d_index, :end_on]).failure(text: 'must be after deduction start_on')
              end
            end
          end

          # Demographic
          if value[:is_applying_coverage] && check_if_blank?(value[:demographic][:is_veteran_or_active_military])
            veteran_fail_key = [:applicants, index, :demographic, :is_veteran_or_active_military]
            key(veteran_fail_key).failure(text: 'cannot be blank when is_applying_coverage is true')
          end

          age_of_applicant = applicant_age(value[:demographic][:dob])

          # FosterCare
          foster_care = value[:foster_care]
          foster_failure_key = [:applicants, index, :foster_care]
          if Types::FosterCareRange.cover?(age_of_applicant)
            foster_care_range_err = "must be filled if age of applicant is within #{Types::FosterCareRange}"
            if check_if_blank?(foster_care[:is_former_foster_care])
              key(foster_failure_key + [:is_former_foster_care]).failure(text: foster_care_range_err)
            end

            if foster_care[:is_former_foster_care]
              if check_if_blank?(foster_care[:age_left_foster_care])
                key(foster_failure_key + [:age_left_foster_care]).failure(text: foster_care_range_err)
              end

              if check_if_blank?(foster_care[:foster_care_us_state])
                key(foster_failure_key + [:foster_care_us_state]).failure(text: foster_care_range_err)
              end

              if check_if_blank?(foster_care[:had_medicaid_during_foster_care])
                key(foster_failure_key + [:had_medicaid_during_foster_care]).failure(text: foster_care_range_err)
              end
            end
          end

          # Incomes
          if any_income?(value) && check_if_blank?(value[:incomes])
            err = 'atleast one income should be present if has_job_income/has_self_employment_income/has_unemployment_income/has_other_income is true'
            key([:applicants, index, :incomes]).failure(text: err)
          end

          if check_if_present?(value[:incomes]) && value[:incomes].is_a?(Array)
            value[:incomes].each_with_index do |income, i_index|
              # end_on
              if check_if_present?(income[:end_on]) && income[:start_on] && income[:end_on] < income[:start_on]
                key([:applicants, index, :incomes, i_index, :end_on]).failure(text: 'must be after income start_on')
              end
            end
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

            # if check_if_blank?(pregnancy[:pregnancy_due_on])
            #   key(pregnancy_failure_key + [:pregnancy_due_on]).failure(text: 'must be filled if the applicant is pregnant')
            # end
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

          # Phone
          if check_if_present?(value[:phones]) && value[:phones].is_a?(Array)
            value[:phones].each_with_index do |phone, p_index|
              # end_on
              if check_if_present?(phone[:end_on]) && phone[:start_on] && phone[:end_on] < phone[:start_on]
                key([:applicants, index, :phones, p_index, :end_on]).failure(text: 'must be after phone start_on')
              end
            end
          end

          # Email
          if check_if_present?(value[:emails]) && value[:emails].is_a?(Array)
            value[:emails].each_with_index do |email, e_index|
              # end_on
              if check_if_present?(email[:end_on]) && email[:start_on] && email[:end_on] < email[:start_on]
                key([:applicants, index, :emails, e_index, :end_on]).failure(text: 'must be after email start_on')
              end
            end
          end

          # Address
          # rubocop:disable Style/Next
          if check_if_present?(value[:addresses]) && value[:addresses].is_a?(Array)
            value[:addresses].each_with_index do |address, add_index|
              # end_on
              if check_if_present?(address[:end_on]) && address[:start_on] && address[:end_on] < address[:start_on]
                key([:applicants, index, :addresses, add_index, :end_on]).failure(text: 'must be after address start_on')
              end
            end
          end
          # rubocop:enable Style/Next
        end

        def more_than_one_determination?(ped)
          [ped[:is_ia_eligible],
           ped[:is_medicaid_chip_eligible] || ped[:is_magi_medicaid],
           ped[:is_totally_ineligible],
           ped[:is_uqhp_eligible]].count(true) > 1
        end

        rule(:tax_households).each do |index:|
          value[:tax_household_members].each_with_index do |thhm, thhm_index|
            ped = thhm[:product_eligibility_determination]

            if ped[:is_csr_eligible] && check_if_blank?(ped[:csr])
              key_name = [:tax_households, index, :tax_household_members, thhm_index, :product_eligibility_determination, :csr]
              key(key_name).failure(text: 'cannot be empty when is_csr_eligible is answered.')
            end

            # rubocop:disable Style/Next
            if more_than_one_determination?(ped)
              key_name = [:tax_households, index, :tax_household_members, thhm_index, :product_eligibility_determination]
              msg = 'Member is eligible for more than one eligibilities:'\
                    ' [:is_ia_eligible, :is_medicaid_chip_eligible, :is_magi_medicaid,'\
                    ' :is_totally_ineligible, :is_without_assistance]'
              key(key_name).failure(text: msg)
              # rubocop:enable Style/Next
            end
          end
        end

        # Notice Options
        rule(:notice_options) do
          if key? && value[:send_eligibility_notices] && value[:send_open_enrollment_notices]
            key(:notice_options).failure(text: 'cannot send both eligibility_notices & open_enrollment_notices.')
          end

          if key? && !value[:send_eligibility_notices] && !value[:send_open_enrollment_notices]
            key(:notice_options).failure(text: 'must send eligibility_notices or open_enrollment_notices.')
          end
        end
      end
    end
  end
end
