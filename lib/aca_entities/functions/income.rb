# frozen_string_literal: true

module AcaEntities
  module Functions
    # build IAP income
    class Income

      attr_reader :attestations_annual_income_hash, :attestations_income_hash

      def call(memoized_data, member)
        @attestations_annual_income_hash = memoized_data.find(Regexp.new("attestations.members.#{member.name.split('.').last}.income"))&.first&.item
        @attestations_income_hash = attestations_annual_income_hash.present? ? attestations_annual_income_hash[:currentIncome] : nil

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
          "SCHOLARSHIP" => "scholarship_payments",
      }.freeze

      TAX_INCOME_KIND = SELF_EMPLOYMENT.merge(OTHER_INCOME_TYPE_KIND).merge(EMPLOYEMENT).merge(UNEMPLOYMENT_INCOME_KIND)

      DEDUCTION_TYPE = {
          "ALIMONY_PAYMENT" => 'alimony_paid',
          "STUDENT_LOAN_INTEREST" => 'student_loan_interest',
          "JURY_DUTY_PAY" => "other",
          "OTHER_DEDUCTION" => 'other',
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
            avg_hours = income[:averageWeeklyWorkHours]
            avg_days = income[:averageWeeklyWorkDays]
          end

          case frequency
            when "ANNUALLY"
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
            when "ONE_TIME"
              amount += income[:incomeAmount]
            when "QUARTERLY"
              q_anual_income = income[:incomeAmount] * 4
              amount += q_anual_income
            when "DAILY"
              week_income = avg_days.to_i * income[:incomeAmount]
              h_anual_income = week_income * 52
              amount += h_anual_income
          end
        end

        (annual_amount - amount) > 200
      end

      def annual_amount
        return 0.0 unless attestations_annual_income_hash || attestations_annual_income_hash[:annualTaxIncome]

        if attestations_annual_income_hash[:annualTaxIncome][:incomeAmount]
          attestations_annual_income_hash[:annualTaxIncome][:incomeAmount]
        else
          0.0
        end
      end

      def income_amount(income)
        frequency = income[:incomeFrequencyType]
        amount = income[:incomeAmount]
        hours = income[:job][:averageWeeklyWorkHours] if income[:job]
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
        if frequency == "ONE_TIME"
          Date.parse('2021-12-31')
        end
      end

      def negative_income(income)
        income[:incomeAmount] < 0 && NEGATIVE_AMOUNT_INCOME_TYPE_KINDS.exclude?(income[:incomeSourceType])
      end

      def job_income_hash
        return [] if attestations_income_hash.blank? || create_other_tax_income

        attestations_income_hash.each_with_object([]) do |(_k, income), result|
          next unless EMPLOYEMENT[income[:incomeSourceType]].present?
          next if negative_income(income)
          result << {
              'kind' => EMPLOYEMENT[income[:incomeSourceType]],
              'amount' => income_amount(income),
              'amount_tax_exempt' => 0,
              'employer_name' => income[:jobIncome].nil? ? "employer name not provided" : income[:jobIncome][:employerName],
              'frequency_kind' => FREQUENCY_KINDS[income[:incomeFrequencyType]],
              'start_on' => Date.parse('2021-01-01'), # default value
              'end_on' => end_on(income),
              'is_projected' => false, # default value
              'employer_address' =>
                  {
                      'address_1' => 'no address', # default value
                      'address_2' => '',
                      'address_3' => '',
                      'county' => '',
                      'country_name' => '',
                      'kind' => 'work', # default value
                      'city' => 'was', # default value
                      'state' => 'DC', # default value
                      'zip' => '00000' # default value
                  },
              'employer_phone' =>
                  {
                      'kind' => 'work', # default value
                      'country_code' => '',
                      'area_code' => '123', # default value
                      'number' => '4567890', # default value
                      'extension' => '',
                      'full_phone_number' => '1234567890' # default value
                  }
          }
          result
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
            if negative_income(income) && TAX_INCOME_KIND[income[:incomeSourceType]].blank?
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

