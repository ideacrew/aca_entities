# frozen_string_literal: true

# rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength, Layout/LineLength, Metrics/AbcSize, Metrics/ClassLength
module AcaEntities
  module Functions
    # build application and applicants
    class BuildApplication
      def call(context)
        @memoized_data = context
        @primary_applicant_identifier = @memoized_data.resolve('family.family_members.is_primary_applicant').item
          # require 'pry';binding.pry
        result = @memoized_data.find('computed.members').each_with_object([]) do |member, collector|
          @member_identifier = member.name.split('.').last

          m_identifier = "attestations.members.#{@member_identifier}"
          @attestations_family_hash = @memoized_data.find(Regexp.new("#{m_identifier}.family"))&.first&.item
          @attestations_income_hash = @memoized_data.find(Regexp.new("#{m_identifier}.income"))&.first&.item
          @insurance_coverage_hash = @memoized_data.find(Regexp.new("#{m_identifier}.insuranceCoverage"))&.first&.item

          # collector << member.item.merge!(applicant_hash)
          collector << applicant_hash.merge(person_hbx_id: "#{@member_identifier}:#{member.item[:personTrackingNumber]}")
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
        return [] if @attestations_income_hash.nil?

        result = job_income_hash
        result << self_emp_income_hash[0] unless self_emp_income_hash.empty?
        result << unemp_income_hash[0] unless unemp_income_hash.empty?
        result << other_income_hash[0] unless other_income_hash.empty?
        result
      end

      def job_income_hash
        return [] if @attestations_income_hash.nil?

        @attestations_income_hash.each_with_object([]) do |(_k, income), result|
          next unless income[:incomeSourceType] == 'JOB'
      begin
          result << {
            'kind' => 'wages_and_salaries',
            'amount' => income[:incomeAmount],
            'amount_tax_exempt' => 0,
            'employer_name' => !income[:jobIncome].nil? ? income[:jobIncome][:employerName] : "test emp",
            'frequency_kind' => income[:incomeFrequencyType].capitalize,
            'start_on' => Date.parse('2021-05-07'), # default value
            'end_on' => nil,
            'is_projected' => false, # default value
            'employer_address' =>
             {
               'address_1' => '123test', # default value
               'address_2' => '',
               'address_3' => '',
               'county' => '',
               'country_name' => '',
               'kind' => 'work', # default value
               'city' => 'was', # default value
               'state' => 'DC', # default value
               'zip' => '23421' # default value
             },
            'employer_phone' =>
             {
               'kind' => 'work', # default value
               'country_code' => '',
               'area_code' => '987', # default value
               'number' => '6547890', # default value
               'extension' => '',
               'full_phone_number' => '9876547890' # default value
             }
          }
      rescue => e
        # binding.pry
        end
          result
        end
      end

      def self_emp_income_hash
        return [] if @attestations_income_hash.nil?

        @attestations_income_hash.each_with_object([]) do |(_k, income), result|
          next unless income[:incomeSourceType] == 'SELF_EMPLOYMENT'

          result << {
            'kind' => 'net_self_employment',
            'amount' => income[:incomeAmount],
            'amount_tax_exempt' => 0,
            'frequency_kind' => income[:incomeFrequencyType].capitalize,
            'start_on' => Date.parse('2021-05-07'), # default value
            'end_on' => nil,
            'is_projected' => false
          }
          result
        end
      end

      def unemp_income_hash
        []
        # return if @attestations_income_hash.nil?

        # @attestations_income_hash.each_with_object([]) do |(_k, income), result|
        #   next unless income[:incomeSourceType] == 'unemployment_income'

        #   result << {
        #     "kind"=>"unemployment_income",
        #     "amount"=> income[:incomeAmount],
        #     "amount_tax_exempt"=>0,
        #     "frequency_kind"=> income[:incomeFrequencyType].capitalize,
        #     "start_on"=> Date.parse('2021-05-07'), # default value
        #     "end_on"=> nil,
        #     "is_projected"=> false}
        #   result
        # end
      end

      OTHER_INCOME_TYPE_KIND = {
        alimony_and_maintenance: 'alimony_and_maintenance',
        capital_gains: 'Capital gains',
        dividend: 'Dividends',
        interest: 'Interest',
        pension_retirement_benefits: 'Pension or retirement',
        RENTAL_OR_ROYALTY_INCOME: 'rental_and_royalty',
        social_security_benefit: 'Social Security',
        american_indian_and_alaskan_native: 'American Indian/Alaska Native income',
        employer_funded_disability: 'Employer-funded disability payments',
        estate_trust: 'Estate and trust',
        farming_and_fishing: 'Farming or fishing',
        foreign: 'Foreign income',
        other: 'Other taxable income',
        INVESTMENT_INCOME: 'INVESTMENT_INCOME',
        prizes_and_awards: 'Prizes and awards',
        scholorship_payments: 'Taxable scholarship payments'
      }.freeze

      def other_income_hash
        return [] if @attestations_income_hash.nil?

        @attestations_income_hash.each_with_object([]) do |(_k, income), result|
          next if OTHER_INCOME_TYPE_KIND[:"#{income[:incomeSourceType]}"].nil?

          result << {
            'kind' => OTHER_INCOME_TYPE_KIND[:"#{income[:incomeSourceType]}"],
            'amount' => income[:incomeAmount],
            'amount_tax_exempt' => 0,
            'frequency_kind' => income[:incomeFrequencyType].capitalize,
            'start_on' => Date.parse('2021-05-07'), # default value
            'end_on' => nil,
            'is_projected' => false
          }
          result
        end
      end

      DEDUCTION_TYPE = {
        ALIMONY_PAYMENT: 'alimony_paid',
        deductable_part_of_self_employment_taxes: 'Deductible part of self-employment taxes',
        domestic_production_activities: 'Domestic production activities deduction',
        penalty_on_early_withdrawal_of_savings: 'Penalty on early withdrawal of savings',
        educator_expenses: 'Educator expenses',
        self_employment_sep_simple_and_qualified_plans: 'Self-employmed SEP, SIMPLE, and qualified plans',
        self_employed_health_insurance: 'Self-employed health insurance',
        student_loan_interest: 'Student loan interest',
        moving_expenses: 'Moving expenses',
        health_savings_account: 'Health savings account',
        ira_deduction: 'IRA deduction',
        reservists_performing_artists_and_fee_basis_government_official_expenses: 'Certain business expenses of reservists, performing artists, and fee-basis government officials',
        tuition_and_fees: 'Tuition and fees',
        OTHER_DEDUCTION: 'OTHER_DEDUCTION'
      }.freeze

      def deduction_hash
        return [] if @attestations_income_hash.nil?

        @attestations_income_hash.each_with_object([]) do |(_k, income), result|
          next if DEDUCTION_TYPE[:"#{income[:incomeSourceType]}"].nil?

          result << {
            'kind' => DEDUCTION_TYPE[:"#{income[:incomeSourceType]}"],
            'amount' => income[:incomeAmount],
            'amount_tax_exempt' => 0,
            'frequency_kind' => income[:incomeFrequencyType].capitalize,
            'start_on' => Date.parse('2021-05-07'), # default value
            'end_on' => nil,
            'is_projected' => false
          }
          result
        end
      end

      def benefits_hash
        return [] if @insurance_coverage_hash.nil?

        result = []
        %w[is_enrolled is_eligible].each do |status| # default loop , should get value from payload
          @insurance_coverage_hash[:enrolledCoverages].each do |ic|
            next if ic[:insuranceMarketType] == 'NONE'

            result << {
              'kind' => ic[:insuranceMarketType]&.downcase, # default value
              'status' => status,
              # 'insurance_kind' => ic['insuranceMarketType'],
              'start_on' => Date.parse('2021-05-07'), # default value
              'end_on' => nil
            }
          end
        end
        result
      end

      def benefits_esc_hash
        return [] if @insurance_coverage_hash.nil?
        return [] unless @insurance_coverage_hash[:employerSponsoredCoverageOffers]
        @insurance_coverage_hash[:employerSponsoredCoverageOffers].each_with_object([]) do |(_k, esc), result|
          begin
          result << {
            'employee_cost' => (esc[:lcsopPremium] || "0.0"),
            'kind' => 'employer_sponsored_insurance', # default value
            'status' => 'is_enrolled', # default value
            # 'insurance_kind' => 'employer_sponsored_insurance', # default value
            :employer => { employer_name: esc[:employer][:name],
                           employer_id: '123456789' }, # default value
            'is_esi_waiting_period' => esc[:waitingPeriodIndicator],
            'is_esi_mec_met' => esc[:employerOffersMinValuePlan],
            'esi_covered' => 'self', # default value
            'start_on' => Date.parse('2021-05-07'), # default value
            'end_on' => nil,
            'employee_cost_frequency' => (esc[:lcsopPremiumFrequencyType]&.capitalize || "Monthly"),
            'employer_address' =>
            {
              'address_1' => '21313312', # default value
              'address_2' => '',
              'address_3' => '',
              'county' => '',
              'country_name' => '',
              'kind' => 'work', # default value
              'city' => 'was',  # default value
              'state' => 'DC',  # default value
              'zip' => '31232'
            }, # default value
            'employer_phone' =>
            {
              'kind' => 'work', # default value
              'country_code' => '',
              'area_code' => emp_phone(esc) != nil ? emp_phone(esc)[0..2] : nil,
              'number' => emp_phone(esc) != nil ? emp_phone(esc)[3..9] : nil,
              'extension' => '',
              'full_phone_number' => emp_phone(esc) != nil ?  emp_phone(esc) : nil
            }
          }
          rescue => e
          # binding.pry
          end
          result
        end
      end

      def emp_phone(esc)  #TODO refactor
        if esc[:employer][:employerPhoneNumber] != nil
          esc[:employer][:employerPhoneNumber]
        elsif esc[:employer][:contact] != nil
          esc[:employer][:contact][:phoneNumber]
        end
      end

      def name_hash
        { first_name: @memoized_data.find(Regexp.new("first_name.#{@member_identifier}"))&.first&.item,
          middle_name: @memoized_data.find(Regexp.new("middle_name.#{@member_identifier}"))&.first&.item || 'nil',
          # default value, create new contract and entities for create family and IAP
          last_name: @memoized_data.find(Regexp.new("last_name.#{@member_identifier}"))&.first&.item,
          name_sfx: @memoized_data.find(Regexp.new("name_sfx.#{@member_identifier}"))&.first&.item || 'nil',
          name_pfx: @memoized_data.find(Regexp.new("name_pfx.#{@member_identifier}"))&.first&.item || 'nil',
          full_name: [@memoized_data.find(Regexp.new("first_name.#{@member_identifier}"))&.first&.item,
                      @memoized_data.find(Regexp.new("last_name.#{@member_identifier}"))&.first&.item].join('.'),
          alternate_name: @memoized_data.find(Regexp.new("alternate_name.#{@member_identifier}"))&.first&.item || 'nil' }
      end

      def demographic_hash
        veteran_indicator = @memoized_data.find(Regexp.new("#{@member_identifier}.other.veteranIndicator"))&.first&.item

        { gender: @memoized_data.find(Regexp.new("person_demographics.gender.#{@member_identifier}"))&.first&.item&.capitalize,
          dob: @memoized_data.find(Regexp.new("person_demographics.dob.#{@member_identifier}"))&.first&.item,
          ethnicity: [],
          race: nil,
          is_veteran_or_active_military: veteran_indicator || false,
          is_vets_spouse_or_child: nil }
      end

      def attestation_hash
        m_identifier_non_magi = "attestations.members.#{@member_identifier}.nonMagi"
        non_magi = @memoized_data.find(Regexp.new(m_identifier_non_magi)).map(&:item).last

        {
          is_incarcerated: false, # default value
          is_self_attested_disabled: non_magi.nil? ? false : non_magi[:blindOrDisabledIndicator],
          is_self_attested_blind: non_magi.nil? ? false : non_magi[:blindOrDisabledIndicator],
          is_self_attested_long_term_care: non_magi.nil? ? false : non_magi[:longTermCareIndicator]
        }
      end

      def pregnancy_information_hash
        {
          is_pregnant: @attestations_family_hash[:pregnancyIndicator] || false,
          is_enrolled_on_medicaid: nil,
          is_post_partum_period: false, # default value
          expected_children_count: @attestations_family_hash[:babyDueQuantity],
          pregnancy_due_on: nil,
          pregnancy_end_on: nil
        }
      end

      def foster_care_hash
        {
          is_former_foster_care: @attestations_family_hash[:fosterCareIndicator],
          age_left_foster_care: @attestations_family_hash[:fosterCareEndAge],
          foster_care_us_state: @attestations_family_hash[:fosterCareState],
          had_medicaid_during_foster_care: @attestations_family_hash[:medicaidDuringFosterCareIndicator]
        }
      end

      def student_hash
        {
          is_student: !@attestations_family_hash[:fullTimeStatusIndicator].nil?,
          student_kind: @attestations_family_hash[:fullTimeStatusIndicator] ? 'full_time' : nil, # needs refactor for other student kinds
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
        non_magi = @memoized_data.find(Regexp.new('attestations.members.*.nonMagi')).map(&:item).last

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
          is_applying_coverage: @memoized_data.find(Regexp.new("is_coverage_applicant.#{@member_identifier}"))&.first&.item, # default value
          is_consent_applicant: nil,
          vlp_document: nil,
          family_member_reference: family_member_reference_hash,
          person_hbx_id: '1234', # default value
          is_required_to_file_taxes: @attestations_family_hash[:taxFilerIndicator], # default value
          tax_filer_kind: 'tax_filer', # default value . #To memoise and extract data from taxRelationships
          is_joint_tax_filing: @attestations_family_hash[:taxReturnFilingStatusType] == 'MARRIED_FILING_JOINTLY',
          # # add method to check for joint filing using this value
          is_claimed_as_tax_dependent: @attestations_family_hash[:taxDependentIndicator],
          claimed_as_tax_dependent_by: nil, # default value
          student: student_hash,
          is_refugee: nil, # default value
          is_trafficking_victim: nil, # default value
          foster_care: foster_care_hash,
          pregnancy_information: pregnancy_information_hash,
          is_subject_to_five_year_bar: nil, # default value
          is_five_year_bar_met: nil, # default value
          is_forty_quarters: nil, # default value
          is_ssn_applied: nil, # default value
          non_ssn_apply_reason: nil, # default value
          moved_on_or_after_welfare_reformed_law: nil, # default value
          is_currently_enrolled_in_health_plan: nil, # default value
          has_daily_living_help: nil, # default value
          need_help_paying_bills: nil, # default value
          has_job_income: !job_income_hash.empty?,
          has_self_employment_income: !self_emp_income_hash.empty?,
          has_unemployment_income: !unemp_income_hash.empty?,
          has_other_income: !other_income_hash.empty?,
          has_deductions: !deduction_hash.empty?,
          has_enrolled_health_coverage: !benefits_hash.empty?, # default value
          has_eligible_health_coverage: !benefits_hash.empty?, # default value
          addresses: [], # default value
          emails: [], # default value
          phones: [], # default value
          incomes: income_hash || [],
          benefits: benefits_hash << (benefits_esc_hash ? benefits_esc_hash[0] : []),
          deductions: deduction_hash || [],
          is_medicare_eligible: false, # default value
          has_insurance: false, # default value
          has_state_health_benefit: false, # default value
          had_prior_insurance: false, # default value
          # prior_insurance_end_date: Date.parse("2021-05-07"), # default value
          age_of_applicant: AcaEntities::Functions::AgeOn.new(on_date: Date.parse('2021-05-07'))
                                                         .call(@memoized_data.find(Regexp.new("person_demographics.dob.#{@member_identifier}"))&.first&.item),
          is_self_attested_long_term_care: non_magi.nil? ? false : non_magi[:longTermCareIndicator],
          hours_worked_per_week: '2'
        }
      end
    end
  end
end
# rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength, Layout/LineLength, Metrics/AbcSize, Metrics/ClassLength
