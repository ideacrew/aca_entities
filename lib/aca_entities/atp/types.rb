# frozen_string_literal: true

require 'dry-types'
require 'bigdecimal'

module AcaEntities
  module Atp
    # list of ATP mappings
    module Types
      send(:include, Dry.Types)
      send(:include, Dry::Logic)

      IncomeKinds = {
        "Wages" => "wages_and_salaries",
        "SelfEmployment" => "net_self_employment",
        "Unemployment" => "unemployment_income"
      }.freeze

      OtherIncomeKinds = {
        'Alimony' => 'alimony_and_maintenance',
        'CapitalGains' => 'capital_gains',
        'Interest' => 'interest',
        'Pension' => 'pension_retirement_benefits',
        'Retirement' => 'pension_retirement_benefits',
        'RentalOrRoyalty' => 'rental_and_royalty',
        'SocialSecurity' => 'social_security_benefit',
        'FarmingOrFishing' => 'farming_and_fishing',
        'Unspecified' => 'other',
        'Winnings' => 'prizes_and_awards',
        'Scholarship' => 'scholorship_payments',
        'CanceledDebt' => 'other',
        'CourtAward' => 'other',
        'JuryDuty' => 'other',
        'CashSupport' => 'other'
      }.freeze

      FrequencyCodeMap = {
        "annually" => "yearly",
        'biweekly' => 'biweekly',
        'daily' => 'daily',
        'semiannually' => 'half_yearly',
        'monthly' => 'monthly',
        'quarterly' => 'quarterly',
        'weekly' => 'weekly',
        'hourly' => 'hourly',
        'once' => 'yearly'
      }.freeze

      DeductionKinds = {
        # alimony and student loan interest are mapped via specific category code types in the schema
        'Alimony' => 'alimony_paid',
        'StudentLoanInterest' => 'student_loan_interest',
        # the remaining kinds are mapped via category text and are not specified in the schema
        'Deductible part of self-employment tax' => 'deductable_part_of_self_employment_taxes',
        'Domestic production activities deduction' => 'domestic_production_activities',
        'Penalty on early withdrawal of savings' => 'penalty_on_early_withdrawal_of_savings',
        'Educator expenses' => 'educator_expenses',
        'Self-employed SEP, SIMPLE, and qualified plans' => 'self_employment_sep_simple_and_qualified_plans',
        # 'Self-employed health insurance' => 'self_employed_health_insurance',
        # 'Moving expenses' => 'moving_expenses',
        'Health savings account deduction' => 'health_savings_account',
        'IRA deduction' => 'ira_deduction',
        'Certain business expenses of reservists, performing artists, and fee-basis government officials' =>
        'reservists_performing_artists_and_fee_basis_government_official_expenses'
        # 'Tuition and fees' => 'tuition_and_fees',
        # 'OTHER_DEDUCTION' => 'OTHER_DEDUCTION',
      }.freeze

      InsuranceKinds = {
        'Private' => 'private_individual_and_family_coverage',
        'CHIP' => 'child_health_insurance_plan',
        'Medicaid' => 'medicaid',
        'Medicare' => 'medicare',
        'TRICARE' => 'tricare',
        'COBRA' => 'cobra',
        'VeteranHealthProgram' => 'veterans_benefits',
        'PeaceCorps' => 'health_care_for_peace_corp_volunteers',
        'Employer' => "employer_sponsored_insurance",
        'UnspecifiedFullCoverage' => 'other_full_benefit_coverage',
        'UnspecifiedLimitedCoverage' => 'other_limited_benefit_coverage'
      }.freeze

      InsuranceKindsOutbound = {
        'private_individual_and_family_coverage' => 'Private',
        'child_health_insurance_plan' => 'CHIP',
        'medicaid' => 'Medicaid',
        'medicare' => 'Medicare',
        'tricare' => 'TRICARE',
        'cobra' => 'Private',
        'private_health_insurance_plan' => 'Private',
        'veterans_benefits' => 'VeteranHealthProgram',
        'health_care_for_peace_corp_volunteers' => 'PeaceCorps',
        "employer_sponsored_insurance" => 'Employer',
        'other_full_benefit_coverage' => 'UnspecifiedFullCoverage',
        'other_limited_benefit_coverage' => 'UnspecifiedLimitedCoverage'
      }.freeze

      ContactKinds = {
        'home' => 'Home', # mail, text, email
        'work' => 'Work', # text, email
        'mailing' => 'Mailing', # mail
        'mobile' => 'Mobile' # text

        # Enroll kinds with no accepted mapping:
        #  - fax
        #  - phone
        #  - main
        #  - primary
        #  - branch
      }.freeze

      ContactPreferenceCode = {
        "Paper, Electronic and Text Message communications" => "Email",
        "Electronic and Text Message communications" => "Email",
        "Paper and Electronic communications" => "Email",
        "Paper and Text Message communications" => "Mail",
        "Only Text Message communication" => "TextMessage",
        "Only Paper communication" => "Mail",
        "Only Electronic communications" => "Email"
      }.freeze
    end
  end
end