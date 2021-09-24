# frozen_string_literal: true

# rubocop:disable Metrics/ClassLength, Naming/PredicateName, Metrics/CyclomaticComplexity, Metrics/MethodLength
module AcaEntities
  module Functions
    # build IAP income
    class Income

      attr_reader :attestations_annual_income_hash, :attestations_income_hash, :insurance_coverage

      def call(memoized_data, member)
        @attestations_annual_income_hash = memoized_data.find(Regexp.new("attestations.members.#{member.name.split('.').last}.income"))&.first&.item
        @attestations_income_hash = attestations_annual_income_hash.present? ? attestations_annual_income_hash[:currentIncome] : nil
        @insurance_coverage = memoized_data.find(Regexp.new("attestations.members.#{member.name.split('.').last}.insuranceCoverage"))&.first&.item

        member_incomes
      end

      private

      def member_incomes
        {
          has_job_income: !job_income_hash.empty?,
          has_self_employment_income: !self_emp_income_hash.empty?,
          has_unemployment_income: !unemp_income_hash.empty?,
          has_other_income: !other_income_hash.empty?,
          has_deductions: !deduction_hash.empty?,
          incomes: income_hash || [],
          deductions: deduction_hash || []
        }
      end

      # annual income keys
      # "incomeAmount",
      # "unknownIncomeIndicator",
      # "variableIncomeIndicator",
      # "incomeLessExplainedIndicator",
      # "taxHouseholdIncomeDifferenceReasonType",
      # "variableIncomeDescriptionText",
      # "taxHouseholdIncomeDiscrepancyDescriptionText"

      # current income keys
      # "currentIncome",  # income number
      # "sequenceNumber",
      # "incomeAmount",
      # "incomeSourceType",
      # "incomeFrequencyType",
      # "estimatedForAptcIndicator",  # TODO check this filed
      # "averageWeeklyWorkHours",
      # "jobIncome"
      # "employerName",
      # "selfEmploymentIncomeDescription",
      # "otherDeductionDescription",
      # "incomeDescription",
      # "unemploymentIncome"
      # "expirationDate",    # TODO check this filed
      # "incomeDifferenceReason",
      # "incomeFederallyRestrictedIndicator",
      # "averageWeeklyWorkDays",
      # "calculatedMonthlyIncomeEquivalentIndicator",
      # "otherIncomeDifferenceReason",
      # "tribalIncomeAmount"   # TODO check this filed

      # incomeSourceType
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

      # incomeFrequencyType
      # ["ANNUALLY", "HOURLY",
      # "MONTHLY", "WEEKLY",
      # "BI_WEEKLY", "SEMI_MONTHLY",
      # "ONE_TIME", "QUARTERLY", "DAILY"]

      FREQUENCY_KINDS = {
        "BI_WEEKLY" => "biweekly",
        "DAILY" => "daily",
        "MONTHLY" => "monthly",
        "QUARTERLY" => "quarterly",
        "WEEKLY" => "weekly",
        "ANNUALLY" => "yearly",
        "ONE_TIME" => "yearly",
        "HOURLY" => "weekly",
        "SEMI_MONTHLY" => "monthly"
      }.freeze

      EMPLOYEMENT = {
        "JOB" => "wages_and_salaries"
      }.freeze

      SELF_EMPLOYMENT = {
        "SELF_EMPLOYMENT" => "net_self_employment"
      }.freeze

      UNEMPLOYMENT_INCOME_KIND = {
        "UNEMPLOYMENT" => 'unemployment_income'
      }.freeze

      OTHER_INCOME_TYPE_KIND = {
        "ALIMONY_RECEIVED" => 'alimony_and_maintenance',
        "CAPITAL_GAINS" => 'capital_gains',
        "PENSION" => 'pension_retirement_benefits',
        "RETIREMENT" => 'pension_retirement_benefits',
        "RENTAL_OR_ROYALTY_INCOME" => 'rental_and_royalty',
        "SOCIAL_SECURITY_BENEFIT" => 'social_security_benefit',
        "FARMING_OR_FISHING_INCOME" => 'farming_and_fishing',
        "OTHER_INCOME" => 'other',
        "INVESTMENT_INCOME" => 'dividend',
        "PRIZES_AWARDS_GAMBLING_WINNINGS" => 'prizes_and_awards',
        "COURT_AWARDS" => "other",
        "CASH_SUPPORT" => "other",
        "SCHOLARSHIP" => "scholarship_payments"
      }.freeze

      TAX_INCOME_KIND = SELF_EMPLOYMENT.merge(OTHER_INCOME_TYPE_KIND).merge(EMPLOYEMENT).merge(UNEMPLOYMENT_INCOME_KIND)

      DEDUCTION_TYPE = {
        "ALIMONY_PAYMENT" => 'alimony_paid',
        "STUDENT_LOAN_INTEREST" => 'student_loan_interest',
        "JURY_DUTY_PAY" => "other",
        "OTHER_DEDUCTION" => 'other'
      }.freeze

      NEGATIVE_AMOUNT_INCOME_TYPE_KINDS = %w[SELF_EMPLOYMENT CAPITAL_GAINS FARMING_OR_FISHING_INCOME].freeze

      def income_hash
        return [] if attestations_income_hash.blank?

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
        attestations_income_hash.any? {|_key, income_hash| income_hash[:incomeFrequencyType] == "ONE_TIME"}
      end

      def taxable_income_with_negative_value
        attestations_income_hash.any? do |_key, income_hash|
          income_hash[:incomeAmount] < 0 && !NEGATIVE_AMOUNT_INCOME_TYPE_KINDS.include?(income_hash[:incomeSourceType])
        end
      end

      def has_other_deduction_income
        attestations_income_hash.any? {|_key, income_hash| income_hash[:incomeSourceType] == "OTHER_DEDUCTION"}
      end

      def create_other_tax_income
        annual_amount != 0 && income_diff_with_annual_income
      end

      def income_diff_with_annual_income
        amount = 0.0
        attestations_income_hash.each_with_object([]) do |(_k, income), _result|
          frequency = income[:incomeFrequencyType]

          if income[:jobIncome]
            avg_hours = income[:jobIncome][:averageWeeklyWorkHours]
            avg_days = income[:jobIncome][:averageWeeklyWorkDays]
          end

          case frequency
          when "ANNUALLY" || "ONE_TIME"
            amount += income[:incomeAmount]
          when "HOURLY"
            week_income = avg_hours.to_i * income[:incomeAmount]
            h_anual_income = week_income * 52
            amount += h_anual_income
          when "MONTHLY"
            m_anual_income = income[:incomeAmount] * 12
            amount += m_anual_income
          when "WEEKLY"
            w_anual_income = income[:incomeAmount] * 52
            amount += w_anual_income
          when "BI_WEEKLY"
            bi_anual_income = income[:incomeAmount] * 26
            amount += bi_anual_income
          when "SEMI_MONTHLY"
            s_monthly = income[:incomeAmount] * 2
            semi_anual_income = s_monthly * 12
            amount += semi_anual_income
          when "QUARTERLY"
            q_anual_income = income[:incomeAmount] * 4
            amount += q_anual_income
          when "DAILY"
            week_income = avg_days.to_i * income[:incomeAmount]
            h_anual_income = week_income * 52
            amount += h_anual_income
          end
        end

        (annual_amount - amount).abs > 200
      end

      def annual_amount
        return 0.0 unless attestations_annual_income_hash
        return 0.0 unless attestations_annual_income_hash[:annualTaxIncome]

        attestations_annual_income_hash[:annualTaxIncome][:incomeAmount] || 0.0
      end

      def income_amount(income)
        frequency = income[:incomeFrequencyType]
        amount = income[:incomeAmount]
        hours = income[:jobIncome][:averageWeeklyWorkHours] if income[:jobIncome]
        if frequency == "HOURLY" && hours
          hours.to_i * amount
        elsif frequency == "SEMI_MONTHLY"
          amount * 2
        else
          amount
        end
      end

      def end_on(income)
        frequency = income[:incomeFrequencyType]
        Date.parse('2021-12-31') if frequency == "ONE_TIME"
      end

      def negative_income(income)
        income[:incomeAmount] < 0 && !NEGATIVE_AMOUNT_INCOME_TYPE_KINDS.include?(income[:incomeSourceType])
      end

      def job_income_hash
        return [] if attestations_income_hash.blank? || create_other_tax_income

        attestations_income_hash.each_with_object([]) do |(_k, income), result|
          next unless EMPLOYEMENT[income[:incomeSourceType]].present?
          next if negative_income(income)
          employer_name = (income[:jobIncome].nil? ? "employer name not provided" : income[:jobIncome][:employerName])
          emp_additional_details = employer_details(employer_name)
          employer_hash = { 'employer_name' => employer_name, 'employer_id' => emp_additional_details[0] }

          if emp_additional_details[1].present?
            employer_phone = {
              'kind' => 'work',
              'country_code' => '',
              'primary' => true,
              'area_code' => emp_additional_details[1][0..2],
              'number' => emp_additional_details[1][3..9],
              'extension' => '',
              'full_phone_number' => emp_additional_details[1]
            }
            employer_hash['employer_phone'] = employer_phone
          end
          result << {
            'kind' => EMPLOYEMENT[income[:incomeSourceType]],
            'amount' => income_amount(income),
            'amount_tax_exempt' => 0,
            'employer' => employer_hash,
            'frequency_kind' => FREQUENCY_KINDS[income[:incomeFrequencyType]],
            'start_on' => Date.parse('2021-01-01'), # default value
            'end_on' => end_on(income),
            'is_projected' => false
          }
          result
        end
      end

      def employer_details(employer_name)
        return [] unless insurance_coverage[:employerSponsoredCoverageOffers]
        insurance_coverage[:employerSponsoredCoverageOffers].each_with_object([]) do |(_k, esc), result|
          if esc[:employer] && esc[:employer][:name] == employer_name
            result << esc[:employer][:employerIdentificationNumber]
            result << esc[:employer][:employerPhoneNumber]
          end
        end
      end

      def self_emp_income_hash
        return [] if attestations_income_hash.blank? || create_other_tax_income
        attestations_income_hash.each_with_object([]) do |(_k, income), result|
          next unless SELF_EMPLOYMENT[income[:incomeSourceType]].present?
          next if negative_income(income)
          result << {
            'kind' => SELF_EMPLOYMENT[income[:incomeSourceType]],
            'amount' => income_amount(income),
            'amount_tax_exempt' => 0,
            'frequency_kind' => FREQUENCY_KINDS[income[:incomeFrequencyType]],
            'start_on' => Date.parse('2021-01-01'), # default value
            'end_on' => end_on(income),
            'is_projected' => false
          }
          result
        end
      end

      def unemp_income_hash
        return [] if attestations_income_hash.blank? || create_other_tax_income
        attestations_income_hash.each_with_object([]) do |(_k, income), result|
          next unless UNEMPLOYMENT_INCOME_KIND[income[:incomeSourceType]].present?
          next if negative_income(income)
          result << {
            "kind" => UNEMPLOYMENT_INCOME_KIND[income[:incomeSourceType]],
            "amount" => income_amount(income),
            "amount_tax_exempt" => 0,
            "frequency_kind" => FREQUENCY_KINDS[income[:incomeFrequencyType]],
            "start_on" => Date.parse('2021-01-01'), # default value
            "end_on" => end_on(income),
            "is_projected" => false
          }
          result
        end
      end

      def other_income_hash
        return [] if attestations_income_hash.blank?
        if create_other_tax_income
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
          attestations_income_hash.each_with_object([]) do |(_k, income), result|
            if negative_income(income) && TAX_INCOME_KIND[income[:incomeSourceType]].present?
              result << {
                'kind' => "other",
                'amount' => income_amount(income),
                'amount_tax_exempt' => 0,
                'frequency_kind' => FREQUENCY_KINDS[income[:incomeFrequencyType]],
                'start_on' => Date.parse('2021-01-01'), # default value
                'end_on' => end_on(income),
                'is_projected' => false
              }
            else
              next unless OTHER_INCOME_TYPE_KIND[income[:incomeSourceType]].present?
              result << {
                'kind' => OTHER_INCOME_TYPE_KIND[income[:incomeSourceType]],
                'amount' => income_amount(income),
                'amount_tax_exempt' => 0,
                'frequency_kind' => FREQUENCY_KINDS[income[:incomeFrequencyType]],
                'start_on' => Date.parse('2021-01-01'), # default value
                'end_on' => end_on(income),
                'is_projected' => false
              }
            end
            result
          end
        end
      end

      def deduction_hash
        return [] if attestations_income_hash.blank? || create_other_tax_income

        attestations_income_hash.each_with_object([]) do |(_k, income), result|
          next unless DEDUCTION_TYPE[income[:incomeSourceType]].present?

          result << {
            'kind' => DEDUCTION_TYPE[income[:incomeSourceType]],
            'amount' => income_amount(income).to_i.abs,
            'amount_tax_exempt' => 0,
            'frequency_kind' => FREQUENCY_KINDS[income[:incomeFrequencyType]],
            'start_on' => Date.parse('2021-01-01'), # default value
            'end_on' => end_on(income),
            'is_projected' => false
          }
          result
        end
      end
    end
  end
end

# rubocop:enable Metrics/ClassLength, Naming/PredicateName, Metrics/CyclomaticComplexity, Metrics/MethodLength