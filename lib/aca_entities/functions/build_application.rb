# frozen_string_literal: true

module AcaEntities
  module Functions
    # build application and applicants
    class BuildApplication
      def call(context)
        @memoized_data = context
        @primary_applicant_identifier = @memoized_data.resolve('family.family_members.is_primary_applicant').item

        result = @memoized_data.find('computed.members').each_with_object([]) do |member, collector|
          @member_identifier = member.name.split('.').last
          @attestations_family_hash = @memoized_data.find(Regexp.new("attestations.members.#{@member_identifier}.family"))&.first&.item
          @attestations_income_hash = @memoized_data.find(Regexp.new("attestations.members.#{@member_identifier}.income"))&.first&.item
          @attestations_insurance_coverage_hash = @memoized_data.find(Regexp.new("attestations.members.#{@member_identifier}.insuranceCoverage"))&.first&.item

          collector << member.item.merge!(applicant_hash)
          collector
        end

        [application_hash.merge!(applicants: result)]
      end

      private

      def application_hash
        {
          hbx_id: '1234', # default value
          us_state: 'ME', # default value
          assistance_year: @memoized_data.resolve('assistance_year').item,
          parent_living_out_of_home_terms: @memoized_data.resolve('parent_living_out_of_home_terms').item,
          report_change_terms: @memoized_data.resolve('report_change_terms').item,
          medicaid_terms: @memoized_data.resolve('medicaid_terms').item,
          is_renewal_authorized: @memoized_data.resolve('is_renewal_authorized').item,
          family_reference: { hbx_id: @memoized_data.resolve('family.hbx_id').item.to_s }
        }
      end

      def income_hash
        return if @attestations_income_hash.nil?

        @attestations_income_hash.each_with_object([]) do |(_k, current_income), result|
          result << { title: nil,
                      kind: 'alimony_and_maintenance', # income[:incomeSourceType] # add method to check for type of income using this value
                      wage_type: nil,
                      hours_per_week: nil,
                      amount: current_income[:incomeAmount],
                      amount_tax_exempt: nil,
                      frequency_kind: current_income[:incomeFrequencyType].capitalize,
                      start_on: Date.today, # default value
                      end_on: nil,
                      is_projected: nil,
                      employer: current_income[:jobIncome] ? current_income[:jobIncome]['employerName'] : nil,
                      has_property_usage_rights: nil,
                      submitted_at: nil }
          result
        end
      end

      def name_hash
        { first_name: @memoized_data.find(Regexp.new("first_name.#{@member_identifier}"))&.first&.item,
          middle_name: @memoized_data.find(Regexp.new("middle_name.#{@member_identifier}"))&.first&.item || 'nil', # deefault value, create new contract and entities for create family and IAP
          last_name: @memoized_data.find(Regexp.new("last_name.#{@member_identifier}"))&.first&.item,
          name_sfx: @memoized_data.find(Regexp.new("name_sfx.#{@member_identifier}"))&.first&.item || 'nil',
          name_pfx: @memoized_data.find(Regexp.new("name_pfx.#{@member_identifier}"))&.first&.item || 'nil',
          full_name: [@memoized_data.find(Regexp.new("first_name.#{@member_identifier}"))&.first&.item, @memoized_data.find(Regexp.new("last_name.#{@member_identifier}"))&.first&.item].join('.'),
          alternate_name: @memoized_data.find(Regexp.new("alternate_name.#{@member_identifier}"))&.first&.item || 'nil' }
      end

      def demographic_hash
        { gender: @memoized_data.find(Regexp.new("person_demographics.gender.#{@member_identifier}"))&.first&.item.capitalize,
          dob: @memoized_data.find(Regexp.new("person_demographics.dob.#{@member_identifier}"))&.first&.item,
          ethnicity: [],
          race: nil,
          is_veteran_or_active_military: false, # default value
          is_vets_spouse_or_child: nil }
      end

      def attestation_hash
        {
          is_incarcerated: false, # default value
          is_self_attested_disabled: @memoized_data.find(Regexp.new("attestations.members.#{@member_identifier}.nonMagi")).map(&:item).last[:blindOrDisabledIndicator],
          is_self_attested_blind: @memoized_data.find(Regexp.new("attestations.members.#{@member_identifier}.nonMagi")).map(&:item).last[:blindOrDisabledIndicator],
          is_self_attested_long_term_care: @memoized_data.find(Regexp.new('attestations.members.*.nonMagi')).map(&:item).last[:longTermCareIndicator]
        }
      end

      def pregnancy_information_hash
        {
          is_pregnant: @attestations_family_hash[:pregnancyIndicator] || false,
          is_enrolled_on_medicaid: nil,
          is_post_partum_period: false, # default value
          expected_children_count: nil,
          pregnancy_due_on: nil,
          pregnancy_end_on: nil
        }
      end

      def foster_care_hash
        {
          is_former_foster_care: @attestations_family_hash[:fosterCareIndicator],
          age_left_foster_care: nil,
          foster_care_us_state: nil,
          had_medicaid_during_foster_care: nil
        }
      end

      def student_hash
        {
          is_student: nil,
          student_kind: 'full_time', # default value .#@attestations_family_hash[:fullTimeStatusIndicator],
          student_school_kind: nil,
          student_status_end_on: nil
        }
      end

      def family_member_reference_hash
        {
          family_member_hbx_id: '1234', # default value
          first_name: @memoized_data.find(Regexp.new("first_name.#{@member_identifier}"))&.first&.item,
          last_name: @memoized_data.find(Regexp.new("last_name.#{@member_identifier}"))&.first&.item,
          person_hbx_id: '1234', # default value
          is_primary_family_member: @primary_applicant_identifier == @member_identifier
        }
      end

      def citizenship_immigration_hash
        { citizen_status: AcaEntities::Functions::BuildLawfulPresenceDetermination.new.call(@memoized_data, @member_identifier),
          is_resident_post_092296: nil,
          is_lawful_presence_self_attested: nil }
      end

      def applicant_hash
        {
          is_primary_applicant: @member_identifier == @primary_applicant_identifier,
          name: name_hash,
          identifying_information: { encrypted_ssn: nil,
                                     has_ssn: !@memoized_data.find(Regexp.new("person_demographics.ssn.#{@member_identifier}"))&.first&.item.nil? },
          demographic: demographic_hash,
          attestation: attestation_hash,
          native_american_information: nil,
          citizenship_immigration_status_information: citizenship_immigration_hash,
          is_consumer_role: nil,
          is_resident_role: nil,
          is_applying_coverage: true, # default value
          is_consent_applicant: nil,
          vlp_document: nil,
          family_member_reference: family_member_reference_hash,
          person_hbx_id: '1234', # default value
          is_required_to_file_taxes: false, # default value
          tax_filer_kind: 'single', # default value . #To memoise and extract data from taxRelationships
          is_joint_tax_filing: true, # @attestations_family_hash[:taxReturnFilingStatusType],# default value # add method to check for joint filing using this value
          is_claimed_as_tax_dependent: @attestations_family_hash[:taxDependentIndicator],
          claimed_as_tax_dependent_by: nil,
          student: student_hash,
          is_refugee: nil,
          is_trafficking_victim: nil,
          foster_care: foster_care_hash,
          pregnancy_information: pregnancy_information_hash,
          is_subject_to_five_year_bar: nil,
          is_five_year_bar_met: nil,
          is_forty_quarters: nil,
          is_ssn_applied: nil,
          non_ssn_apply_reason: nil,
          moved_on_or_after_welfare_reformed_law: nil,
          is_currently_enrolled_in_health_plan: nil,
          has_daily_living_help: nil,
          need_help_paying_bills: nil,
          has_job_income: income_hash.nil? ? false : true,
          has_self_employment_income: false, # default value
          has_unemployment_income: false, # default value
          has_other_income: false, # default value
          has_deductions: false, # default value
          has_enrolled_health_coverage: false, # default value
          has_eligible_health_coverage: false, # default value
          addresses: [], # default value
          emails: [], # default value
          phones: [], # default value
          incomes: income_hash || [],
          benefits: [], # default value
          deductions: [], # default value
          is_medicare_eligible: false, # default value
          has_insurance: false, # default value
          has_state_health_benefit: false, # default value
          had_prior_insurance: false, # default value
          # prior_insurance_end_date: Date.today, # default value
          age_of_applicant: AcaEntities::Functions::AgeOn.new(on_date: Date.today).call(@memoized_data.find(Regexp.new("person_demographics.dob.#{@member_identifier}"))&.first&.item),
          is_self_attested_long_term_care: @memoized_data.find(Regexp.new('attestations.members.*.nonMagi')).map(&:item).last[:longTermCareIndicator],
          hours_worked_per_week: '2'
        }
      end
    end
  end
end
