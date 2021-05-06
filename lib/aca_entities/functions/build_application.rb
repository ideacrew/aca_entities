# frozen_string_literal: true

module AcaEntities
  module Functions
    # build application and applicants
    class BuildApplication
      def call(input)
        application = {
          assistance_year: input.resolve('assistance_year').item,
          parent_living_out_of_home_terms: input.resolve('parent_living_out_of_home_terms').item,
          report_change_terms: input.resolve('report_change_terms').item,
          medicaid_terms: input.resolve('medicaid_terms').item,
          is_renewal_authorized: input.resolve('is_renewal_authorized').item
        }

        @primary_applicant_identifier = input.resolve('family.family_members.is_primary_applicant').item
        result = input.find('computed.members').each_with_object([]) do |member, collector|
          @member_identifier = member.name.split('.').last

          @attestations_family_hash = input.find(Regexp.new("attestations.members.#{@member_identifier}.family"))&.first&.item
          @attestations_income_hash = input.find(Regexp.new("attestations.members.#{@member_identifier}.income"))&.first&.item
          @attestations_insurance_coverage_hash = input.find(Regexp.new("attestations.members.#{@member_identifier}.insuranceCoverage"))&.first&.item

          collector << member.item.merge!(serialize)
          collector
        end

        [application.merge!(applicants: result)]
      end

      def income_serialize
        return if @attestations_income_hash.nil?

        @attestations_income_hash.each_with_object([]) do |(_k, income), result|
          result << { title: nil,
                      kind: income[:incomeSourceType],
                      wage_type: nil,
                      hours_per_week: nil,
                      amount: income[:incomeAmount],
                      amount_tax_exempt: nil,
                      frequency_kind: income[:incomeFrequencyType],
                      start_on: nil,
                      end_on: nil,
                      is_projected: nil,
                      employer: income[:jobIncome] ? income[:jobIncome]['employerName'] : nil,
                      has_property_usage_rights: nil,
                      submitted_at: nil }
          result
        end
      end

      def serialize
        { is_primary_applicant: @member_identifier == @primary_applicant_identifier,
          name: { first_name: nil,
                  middle_name: nil,
                  last_name: nil,
                  name_sfx: nil,
                  name_pfx: nil,
                  full_name: nil,
                  alternate_name: nil },
          identifying_information: nil,
          demographic: nil,
          attestation: {
            is_incarcerated: nil,
            is_self_attested_disabled: 'blindOrDisabledIndicator',
            is_self_attested_blind: 'blindOrDisabledIndicator',
            is_self_attested_long_term_care: 'longTermCareIndicator'
          },
          native_american_information: nil,
          citizenship_immigration_status_information: nil,
          is_consumer_role: nil,
          is_resident_role: nil,
          is_applying_coverage: nil,
          is_consent_applicant: nil,
          vlp_document: nil,
          family_member_reference: nil,
          person_hbx_id: nil,
          is_required_to_file_taxes: nil,
          tax_filer_kind: 'taxRelationships',
          is_joint_tax_filing: @attestations_family_hash[:taxReturnFilingStatusType],
          is_claimed_as_tax_dependent: @attestations_family_hash[:taxDependentIndicator],
          claimed_as_tax_dependent_by: nil,
          student: {
            is_student: nil,
            student_kind: @attestations_family_hash[:fullTimeStatusIndicator],
            student_school_kind: nil,
            student_status_end_on: nil
          },
          is_refugee: nil,
          is_trafficking_victim: nil,
          foster_care: {
            is_former_foster_care: @attestations_family_hash[:fosterCareIndicator],
            age_left_foster_care: nil,
            foster_care_us_state: nil,
            had_medicaid_during_foster_care: nil
          },
          pregnancy_information: {
            is_pregnant: @attestations_family_hash[:pregnancyIndicator],
            is_enrolled_on_medicaid: nil,
            is_post_partum_period: nil,
            expected_children_count: nil,
            pregnancy_due_on: nil,
            pregnancy_end_on: nil
          },
          is_subject_to_five_year_bar: nil,
          is_five_year_bar_met: nil,
          is_forty_quarters: nil,
          is_ssn_applied: nil,
          non_ssn_apply_reason: nil,
          moved_on_or_after_welfare_reformed_law: nil,
          is_currently_enrolled_in_health_plan: nil,
          has_daily_living_help: nil,
          need_help_paying_bills: nil,
          has_job_income: nil,
          has_self_employment_income: nil,
          has_unemployment_income: nil,
          has_other_income: nil,
          has_deductions: nil,
          has_enrolled_health_coverage: nil,
          has_eligible_health_coverage: nil,
          addresses: nil,
          emails: nil,
          phones: nil,
          incomes: income_serialize,
          benefits: nil,
          deductions: nil,
          is_medicare_eligible: nil,
          has_insurance: nil,
          has_state_health_benefit: nil,
          had_prior_insurance: nil,
          prior_insurance_end_date: nil,
          age_of_applicant: nil,
          is_self_attested_long_term_care: nil,
          hours_worked_per_week: nil,
          mitc_income: nil,
          mitc_relationships: nil }
      end
    end
  end
end
