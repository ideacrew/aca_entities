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

          @attestations_annual_income_hash = @memoized_data.find(Regexp.new("#{m_identifier}.income"))&.first&.item
          @attestations_income_hash = @attestations_annual_income_hash.present? ? @attestations_annual_income_hash[:currentIncome] : nil

          @insurance_coverage_hash = @memoized_data.find(Regexp.new("#{m_identifier}.insuranceCoverage"))&.first&.item

          # collector << member.item.merge!(applicant_hash)
          # collector << applicant_hash.merge(person_hbx_id: "#{@member_identifier}:#{member.item[:personTrackingNumber]}")
          collector << applicant_hash.merge(person_hbx_id: @member_identifier)
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

      # {"INVESTMENT_INCOME",
      #  "JOB",
      #  "UNEMPLOYMENT",
      #  "PENSION",
      #  "RETIREMENT",
      #  "STUDENT_LOAN_INTEREST",
      #  "SOCIAL_SECURITY_BENEFIT",
      #  "SELF_EMPLOYMENT",
      #  "OTHER_DEDUCTION",
      #  "OTHER_INCOME",
      #  "RENTAL_OR_ROYALTY_INCOME",
      #  "CAPITAL_GAINS",
      #  "ALIMONY_RECEIVED",
      #  "PRIZES_AWARDS_GAMBLING_WINNINGS",
      #  "ALIMONY_PAYMENT",
      #  "FARMING_OR_FISHING_INCOME",
      #  "COURT_AWARDS",
      #  "CASH_SUPPORT",
      #  "SCHOLARSHIP",
      #  "JURY_DUTY_PAY"}.freeze

      # ["ANNUALLY", "HOURLY", "MONTHLY", "WEEKLY", "BI_WEEKLY",
      #  "SEMI_MONTHLY", "ONE_TIME", "QUARTERLY", "DAILY"]

      FREQUENCY_KINDS = {
          "BI_WEEKLY": "biweekly",
          "DAILY": "daily",
          "MONTHLY": "monthly",
          "QUARTERLY": "quarterly",
          "WEEKLY": "weekly",
          "ANNUALLY": "yearly",
          "ONE_TIME": "",
          "HOURLY": "weekly",
          "SEMI_MONTHLY": "monthly",
      }.freeze

      EMPLOYEMENT = {
        "JOB": "wages_and_salaries",
      }.freeze

      SELF_EMPLOYMENT = {
        "SELF_EMPLOYMENT": "net_self_employment",
      }.freeze

      UNEMPLOYMENT_INCOME_KIND = {
        UNEMPLOYMENT: 'unemployment_income'
      }.freeze

      OTHER_INCOME_TYPE_KIND = {
        "ALIMONY_RECEIVED": 'alimony_and_maintenance',
        "CAPITAL_GAINS": 'capital_gains',
        "PENSION": 'pension_retirement_benefits',
        "RETIREMENT": 'pension_retirement_benefits',
        "RENTAL_OR_ROYALTY_INCOME": 'rental_and_royalty',
        "SOCIAL_SECURITY_BENEFIT": 'social_security_benefit',
        "FARMING_OR_FISHING_INCOME": 'farming_and_fishing',
        "OTHER_INCOME": 'other',
        "INVESTMENT_INCOME": 'dividend',
        "PRIZES_AWARDS_GAMBLING_WINNINGS": 'prizes_and_awards',
        "COURT_AWARDS": "other",  # Need to change
        "CASH_SUPPORT":"other", # Need to change
        "SCHOLARSHIP": "scholarship_payments", # Need to change
        "JURY_DUTY_PAY": "other",     # Need to change
        "OTHER_DEDUCTION": 'other',
      }.freeze

      TaxIncomeKIND = SELF_EMPLOYMENT.merge(OTHER_INCOME_TYPE_KIND)

      DEDUCTION_TYPE = {
        "ALIMONY_PAYMENT": 'alimony_paid',
        "STUDENT_LOAN_INTEREST": 'student_loan_interest',
      }.freeze

      def income_hash
        return [] if @attestations_income_hash.blank?

        result = job_income_hash
        result << self_emp_income_hash[0] unless self_emp_income_hash.empty?
        result << unemp_income_hash[0] unless unemp_income_hash.empty?
        unless other_income_hash.empty?
         other_income_hash.each do |income|
           result << income
         end
        end
        result
      end

      def has_one_time_income
        @attestations_income_hash.any? {|key, income_hash| income_hash[:incomeFrequencyType] == "ONE_TIME"}
      end

      def taxable_income_with_negative_value
        @attestations_income_hash.any? do |key, income_hash|
          income_hash[:incomeAmount] < 0 && TaxIncomeKIND[income_hash[:incomeSourceType]].present?
        end
      end

      def has_other_deduction_income
        @attestations_income_hash.any? {|key, income_hash| income_hash[:incomeSourceType] == "OTHER_DEDUCTION"}
      end

      def create_other_tax_income
        has_one_time_income || taxable_income_with_negative_value || has_other_deduction_income || income_diff_with_annual_income
      end

      def income_diff_with_annual_income
        amount = 0.0
        @attestations_income_hash.each_with_object([]) do |(_k, income), result|
          frequency = income[:incomeFrequencyType]

          if income[:jobIncome]
            avg_hours = income[:averageWeeklyWorkHours]
            avg_days = income[:averageWeeklyWorkDays]
          end

          case frequency
          when "ANNUALLY"
            amount = amount + income[:incomeAmount]
          when "HOURLY"
            week_income = avg_hours.to_i * income[:incomeAmount]
            h_anual_income = week_income * 52
            amount = amount + h_anual_income
          when "MONTHLY"
            m_anual_income = income[:incomeAmount] * 12
            amount = amount + m_anual_income
          when "WEEKLY"
            w_anual_income = income[:incomeAmount] * 52
            amount = amount + w_anual_income
          when "BI_WEEKLY"
            bi_anual_income = income[:incomeAmount] * 26
            amount = amount + bi_anual_income
          when "SEMI_MONTHLY"
            s_monthly = income[:incomeAmount] * 2
            semi_anual_income= s_monthly * 12
            amount = amount + semi_anual_income
          when "ONE_TIME"
            amount = amount + income[:incomeAmount]
          when "QUARTERLY"
            q_anual_income = income[:incomeAmount] * 4
            amount = amount + q_anual_income
          when "DAILY"
            week_income = avg_days.to_i * income[:incomeAmount]
            h_anual_income = week_income * 52
            amount = amount + h_anual_income
          end
        end
        (annual_amount - amount) > 200
      end

      def annual_amount
        if @attestations_annual_income_hash
          @attestations_annual_income_hash[:annualTaxIncome][:incomeAmount]
        else
          0.0
        end
      end

      def income_amount(income)
        frequency = income[:incomeFrequencyType]
        amount = income[:incomeAmount]
        hours = income[:job][:averageWeeklyWorkHours]
        if frequency == "HOURLY" && hours
          hours.to_i * amount
        elsif frequency == "SEMI_MONTHLY"
          amount * 2
        else
          amount
        end
      end

      def job_income_hash
        return [] if @attestations_income_hash.blank? || create_other_tax_income

        @attestations_income_hash.each_with_object([]) do |(_k, income), result|
          next unless EMPLOYEMENT[income[:incomeSourceType]].present?
          result << {
            'kind' => EMPLOYEMENT[income[:incomeSourceType]],
            'amount' => income_amount(income),
            'amount_tax_exempt' => 0,
            'employer_name' => !income[:jobIncome].nil? ? income[:jobIncome][:employerName] : "employer name not provided",
            'frequency_kind' => FREQUENCY_KINDS[income[:incomeFrequencyType]],
            'start_on' => Date.parse('2021-01-01'), # default value
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
          result
        end
      end

      def self_emp_income_hash
        return [] if @attestations_income_hash.blank? || create_other_tax_income
        @attestations_income_hash.each_with_object([]) do |(_k, income), result|
          next unless SELF_EMPLOYMENT[income[:incomeSourceType]].present?
          result << {
            'kind' => SELF_EMPLOYMENT[income[:incomeSourceType]],
            'amount' => income_amount(income),
            'amount_tax_exempt' => 0,
            'frequency_kind' => FREQUENCY_KINDS[income[:incomeFrequencyType]],
            'start_on' => Date.parse('2021-01-01'), # default value
            'end_on' => nil,
            'is_projected' => false
          }
          result
        end
      end

      def unemp_income_hash
        return [] if @attestations_income_hash.blank? || create_other_tax_income
        @attestations_income_hash.each_with_object([]) do |(_k, income), result|
          next unless UNEMPLOYMENT_INCOME_KIND[income[:incomeSourceType]].present?
          result << {
            "kind"=> UNEMPLOYMENT_INCOME_KIND[income[:incomeSourceType]],
            "amount"=> income_amount(income),
            "amount_tax_exempt"=>0,
            "frequency_kind"=> FREQUENCY_KINDS[income[:incomeFrequencyType]],
            "start_on"=> Date.parse('2021-01-01'), # default value
            "end_on"=> nil,
            "is_projected"=> false}
          result
        end
      end

      def other_income_hash
        return [] if @attestations_income_hash.blank?
        if create_other_tax_income
          annual_amount = if @attestations_annual_income_hash
                            @attestations_annual_income_hash[:annualTaxIncome][:incomeAmount]
                          else
                            0.0
                          end

          [{
              'kind' => "other",
              'amount' => annual_amount,
              'amount_tax_exempt' => 0,
              'frequency_kind' => "yearly",
              'start_on' => Date.parse('2021-01-01'), # default value
              'end_on' => nil,
              'is_projected' => false
          }]
        else
          @attestations_income_hash.each_with_object([]) do |(_k, income), result|
            next unless OTHER_INCOME_TYPE_KIND[income[:incomeSourceType]].present?

            result << {
                'kind' => OTHER_INCOME_TYPE_KIND[income[:incomeSourceType]],
                'amount' => income_amount(income),
                'amount_tax_exempt' => 0,
                'frequency_kind' => FREQUENCY_KINDS[income[:incomeFrequencyType]],
                'start_on' => Date.parse('2021-01-01'), # default value
                'end_on' => nil,
                'is_projected' => false
            }
            result
          end
        end
      end

      def deduction_hash
        return [] if @attestations_income_hash.blank? || create_other_tax_income

        @attestations_income_hash.each_with_object([]) do |(_k, income), result|
          next unless DEDUCTION_TYPE[income[:incomeSourceType]].present?

          result << {
            'kind' => DEDUCTION_TYPE[:"#{income[:incomeSourceType]}"] ,
            'amount' => income_amount(income).to_i.abs,
            'amount_tax_exempt' => 0,
            'frequency_kind' => FREQUENCY_KINDS[income[:incomeFrequencyType]],
            'start_on' => Date.parse('2021-01-01'), # default value
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
              'kind' => "private_individual_and_family_coverage", #TODO: check this value #[:insuranceMarketType]&.downcase, # default value
              'status' => status,
              # 'insurance_kind' => ic['insuranceMarketType'],
              'start_on' => Date.parse('2021-01-01'), # default value
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
            'start_on' => Date.parse('2021-01-01'), # default value
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
          middle_name: @memoized_data.find(Regexp.new("middle_name.#{@member_identifier}"))&.first&.item || '',
          # default value, create new contract and entities for create family and IAP
          last_name: @memoized_data.find(Regexp.new("last_name.#{@member_identifier}"))&.first&.item,
          name_sfx: @memoized_data.find(Regexp.new("name_sfx.#{@member_identifier}"))&.first&.item || '',
          name_pfx: @memoized_data.find(Regexp.new("name_pfx.#{@member_identifier}"))&.first&.item || '',
          full_name: [@memoized_data.find(Regexp.new("first_name.#{@member_identifier}"))&.first&.item,
                      @memoized_data.find(Regexp.new("last_name.#{@member_identifier}"))&.first&.item].join('.'),
          alternate_name: @memoized_data.find(Regexp.new("alternate_name.#{@member_identifier}"))&.first&.item || '' }
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
          is_self_attested_disabled: non_magi.nil? ? false : non_magi[:blindOrDisabledIndicator] || false,
          is_self_attested_blind: non_magi.nil? ? false : non_magi[:blindOrDisabledIndicator] || false,
          is_self_attested_long_term_care: non_magi.nil? ? false : (non_magi[:longTermCareIndicator] || false)
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
          is_former_foster_care: @attestations_family_hash[:fosterCareIndicator] || false,
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

          is_required_to_file_taxes: @attestations_family_hash[:taxFilerIndicator] || false,
          tax_filer_kind: tax_filer_kind, # default value . #To memoise and extract data from taxRelationships
          is_joint_tax_filing: @attestations_family_hash[:taxReturnFilingStatusType] == 'MARRIED_FILING_JOINTLY',
          is_filing_as_head_of_household: @attestations_family_hash[:taxReturnFilingStatusType] == 'HEAD_OF_HOUSEHOLD',
          # # add method to check for joint filing using this value
          is_claimed_as_tax_dependent: @attestations_family_hash[:taxDependentIndicator] || false,
          claimed_as_tax_dependent_by: claimed_as_tax_dependent_hash, # default value

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
          benefits: (benefits_hash << (benefits_esc_hash ? benefits_esc_hash[0] : [])).compact,
          deductions: deduction_hash || [],
          is_medicare_eligible: false, # default value
          has_insurance: false, # default value
          has_state_health_benefit: false, # default value
          had_prior_insurance: false, # default value
          # prior_insurance_end_date: Date.parse("2021-05-07"), # default value
          age_of_applicant: AcaEntities::Functions::AgeOn.new(on_date: Date.parse('2021-01-01'))
                                                         .call(@memoized_data.find(Regexp.new("person_demographics.dob.#{@member_identifier}"))&.first&.item),
          is_self_attested_long_term_care: non_magi.nil? ? false : non_magi[:longTermCareIndicator] || false,
          hours_worked_per_week: '2'
        }
      end

      def tax_filer_kind
        if @attestations_family_hash[:taxFilerIndicator]
          "tax_filer"
        elsif @attestations_family_hash[:taxDependentIndicator]
          "dependent"
        else
          "non_filer"
        end
      end

      def claimed_as_tax_dependent_hash
        person_hbx_id = claimed_as_tax_dependent_by.present? ? claimed_as_tax_dependent_by : "1234"
        {first_name: "dummy",last_name: 'dummy', dob: Date.parse("2021-01-01"), person_hbx_id: person_hbx_id}
      end

      def claimed_as_tax_dependent_by
        if @attestations_family_hash[:taxDependentIndicator]
          household = @memoized_data.resolve('attestations.household').item
          found_relationship = household[:taxRelationships].collect do |tax_relationship|
            primary_match = tax_relationship[:no_key][0][:no_key].include?(@primary_applicant_identifier)
            current_member_match = tax_relationship[:no_key][0][:no_key].include?(@member_identifier)
            if primary_match && current_member_match
              tax_relationship[:no_key][0][:no_key]
            elsif current_member_match
              tax_relationship[:no_key][0][:no_key]
            end
          end.compact

          return nil if found_relationship.blank?
          return found_relationship[0][0] if found_relationship.count == 1

          found_relationship_with_primary = found_relationship.detect do |relationship|
            relationship.include?(@primary_applicant_identifier)
          end

          return found_relationship_with_primary[0] if found_relationship_with_primary.present?

          found_relationship_by_member = found_relationship.detect do |relationship|
            relationship.include?(@member_identifier)
          end
          found_relationship_by_member[0]
        end
      end
    end
  end
end
# rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength, Layout/LineLength, Metrics/AbcSize, Metrics/ClassLength
