# frozen_string_literal: true

require 'dry-types'

module AcaEntities
  module MagiMedicaid
    # Extend DryTypes to include MagiMedicaid
    # rubocop:disable Metrics/ModuleLength
    module Types
      include Dry.Types
      include Dry::Logic

      VersionKind = Types::Coercible::String.default('0.1.0').enum('0.1.0')

      Money = Types.Constructor(BigDecimal) { |val| BigDecimal(val.to_s) }

      MinimumEssentialCoverageBenefitKinds = [
        'medicaid',
        'medicare',
        'medicare_advantage',
        'medicare_part_b',
        'employer_sponsored_insurance'
      ].freeze

      HraKind = Types::Coercible::Symbol.enum(:ichra, :qsehra)

      BenefitKind = Types::Coercible::String.enum(
        'private_individual_and_family_coverage', # 'marketplace_coverage'
        'acf_refugee_medical_assistance',
        'americorps_health_benefits',
        'medicaid',
        'child_health_insurance_plan', # 'chip'
        'medicare',
        'medicare_advantage',
        'medicare_part_b',
        'state_supplementary_payment',
        'tricare',
        'veterans_benefits',
        'naf_health_benefit_program',
        'health_care_for_peace_corp_volunteers',
        'department_of_defense_non_appropriated_health_benefits',
        'employer_sponsored_insurance',
        'health_reimbursement_arrangement',
        'cobra',
        'self_funded_student_health_coverage',
        'foreign_government_health_coverage',
        'private_health_insurance_plan',
        'coverage_obtained_through_another_exchange',
        'coverage_under_the_state_health_benefits_risk_pool',
        'retiree_health_benefits',
        'veterans_administration_health_benefits',
        'peace_corps_health_benefits',
        'other_full_benefit_coverage',
        'other_limited_benefit_coverage'
      )

      BenefitStatusKind = Types::Coercible::String.enum('is_eligible', 'is_enrolled')
      EsiCoveredKind    = Types::Coercible::String.enum('self', 'self_and_spouse', 'family')

      DriverQuestionAttributeKind = Types::Coercible::String.enum(
        'has_job_income',
        'has_self_employment_income',
        'has_other_income',
        'has_deductions',
        'has_enrolled_health_coverage',
        'has_eligible_health_coverage'
      )

      IncomeKind = Types::Coercible::String.enum(
        'alimony_and_maintenance',
        'american_indian_and_alaskan_native',
        'capital_gains',
        'dividend',
        'employer_funded_disability',
        'estate_trust',
        'farming_and_fishing',
        'foreign',
        'interest',
        'lump_sum_amount',
        'military',
        'net_self_employment',
        'other',
        'pension_retirement_benefits',
        'permanent_workers_compensation',
        'prizes_and_awards',
        'rental_and_royalty',
        'scholarship_payments',
        'social_security_benefit',
        'supplemental_security_income',
        'tax_exempt_interest',
        'unemployment_income',
        'wages_and_salaries',
        'income_from_irs'
      )

      EarnedIncomeKinds = [
        'wages_and_salaries',
        'net_self_employment',
        'scholarship_payments'
      ].freeze

      DeductionKind = Types::Coercible::String.enum(
        'alimony_paid',
        'deductible_part_of_self_employment_taxes',
        'domestic_production_activities',
        'penalty_on_early_withdrawal_of_savings',
        'educator_expenses',
        'self_employment_sep_simple_and_qualified_plans',
        'self_employed_health_insurance',
        'student_loan_interest',
        'moving_expenses',
        'health_savings_account',
        'ira_deduction',
        'reservists_performing_artists_and_fee_basis_government_official_expenses',
        'tuition_and_fees',
        'other'
      )

      IncomeValidationStateKind   = Types::Coercible::String.enum('na', 'valid', 'outstanding', 'pending')
      MecValidationStateKind      = Types::Coercible::String.enum('na', 'valid', 'outstanding', 'pending')
      NaturalizationDocumentKind  = Types::Coercible::String.enum('Certificate of Citizenship',
                                                                  'Naturalization Certificate')

      StudentKind = Types::Coercible::String.enum(
        'dropped_out',
        'elementary',
        'english_language_institute',
        'full_time',
        'ged',
        'graduated',
        'graduate_school',
        'half_time',
        'junior_school',
        'not_in_school',
        'open_university',
        'part_time',
        'preschool',
        'primary',
        'secondary',
        'technical',
        'undergraduate',
        'vocational',
        'vocational_tech'
      )

      StudentSchoolKind = Types::Coercible::String.enum(
        'english_language_institute',
        'elementary',
        'equivalent_vocational_tech',
        'graduate_school',
        'ged',
        'high_school',
        'junior_school',
        'open_university',
        'pre_school',
        'primary',
        'technical',
        'undergraduate',
        'vocational'
      )

      TaxFilerKind = Types::Coercible::String.enum('tax_filer', 'single', 'joint', 'separate', 'dependent', 'non_filer')

      # List of the documents user can provide to verify Immigration status
      VlpDocumentKind = Types::Coercible::String.enum(
        'I-327 (Reentry Permit)',
        'I-551 (Permanent Resident Card)',
        'I-571 (Refugee Travel Document)',
        'I-766 (Employment Authorization Card)',
        'Certificate of Citizenship',
        'Naturalization Certificate',
        'Machine Readable Immigrant Visa (with Temporary I-551 Language)',
        'Temporary I-551 Stamp (on passport or I-94)',
        'I-94 (Arrival/Departure Record)',
        'I-94 (Arrival/Departure Record) in Unexpired Foreign Passport',
        'Unexpired Foreign Passport',
        'I-20 (Certificate of Eligibility for Nonimmigrant (F-1) Student Status)',
        'DS2019 (Certificate of Eligibility for Exchange Visitor (J-1) Status)',
        'Other (With Alien Number)',
        'Other (With I-94 Number)'
      )

      MagiMedicaidCategoryType = Types::Coercible::String.enum(
        'none',
        'residency',
        'adult_group',
        'parent_caretaker',
        'pregnancy',
        'child',
        'optional_targeted_low_income_child',
        'chip_targeted_low_income_child',
        'unborn_child',
        'income_medicaid_eligible',
        'income_chip_eligible',
        'medicaid_chipra_214',
        'chip_chipra_214',
        'trafficking_victim',
        'seven_year_limit',
        'five_year_bar',
        'title_ii_work_quarters_met',
        'medicaid_citizen_or_immigrant',
        'chip_citizen_or_immigrant',
        'former_foster_care_category',
        'work_quarters_override_income',
        'state_health_benefits_chip',
        'chip_waiting_period_satisfied',
        'dependent_child_covered',
        'medicaid_non_magi_referral',
        'emergency_medicaid',
        'refugee_medical_assistance',
        'aptc_referral'
      )

      BenefitTermMap = {}.freeze

      CitizenKinds = Types::Coercible::String.enum(
        'us_citizen',
        'naturalized_citizen',
        'alien_lawfully_present',
        'lawful_permanent_resident',
        'undocumented_immigrant',
        'not_lawfully_present_in_us',
        'non_native_not_lawfully_present_in_us',
        'ssn_pass_citizenship_fails_with_SSA',
        'non_native_citizen'
      )

      # TODO: verify list
      LawfulPresentCitizenKinds = [
        'us_citizen',
        'naturalized_citizen',
        'alien_lawfully_present',
        'lawful_permanent_resident',
        'non_native_citizen'
      ].freeze

      IncomeType = Types::Coercible::String.enum(
        'CapitalGains',
        'Interest',
        'Wages',
        'RentalOrRoyalty',
        'FarmingOrFishing',
        'Winnings',
        'Alimony',
        'SocialSecurity',
        'Unemployment',
        'RetirementOrPension',
        'CanceledDebt',
        'CourtAward',
        'JuryDuty',
        'SelfEmployment',
        'CashSupport',
        'Scholarship',
        'Unspecified'
      )
      IncomeFrequency = Types::Coercible::String.enum(
        'Weekly',
        'Monthly',
        'Annually',
        'BiWeekly',
        'Quarterly',
        'SemiMonthly',
        'Hourly',
        'Daily',
        'SemiAnnually',
        '13xPerYear',
        '11xPerYear',
        '10xPerYear',
        'Once',
        'biweekly',
        'daily',
        'half_yearly',
        'monthly',
        'quarterly',
        'weekly',
        'yearly'
      )
      # TODO: added enroll income frequency temp, remove after migration

      DeductionFrequency = IncomeFrequency
      EmployeeCostFrequency = IncomeFrequency

      VerificationStatusCode = Types::Coercible::String.enum(
        'FFEVerificationCode', 'AddressVerificationCode', 'DHS-G845VerificationCode', 'DHS-SAVEVerificationCode'
      )
      AddressValidationStatusCode = Types::Coercible::String.enum('ValidMatch', 'PartialMatch', 'NoStreet', 'NoCity')
      ReferralActivityReasonCode = Types::Coercible::String.enum(
        'FullDetermination',
        'WaitingPeriodException',
        'GapFilling'
      )
      ReferralActivityStatusCode = Types::Coercible::String.enum(
        'Initiated',
        'Accepted',
        'Rejected',
        'ProvisionallyAccepted',
        'Updated',
        'PartiallyRejected'
      )

      GenderKind = Types::Coercible::String.enum(
        'Male',
        'Female'
      )

      UsStateAbbreviationKind = Types::String.enum(
        'AL',
        'AK',
        'AS',
        'AZ',
        'AR',
        'CA',
        'CO',
        'CT',
        'DE',
        'DC',
        'FM',
        'FL',
        'GA',
        'GU',
        'HI',
        'ID',
        'IL',
        'IN',
        'IA',
        'KS',
        'KY',
        'LA',
        'ME',
        'MH',
        'MD',
        'MA',
        'MI',
        'MN',
        'MS',
        'MO',
        'MT',
        'NE',
        'NV',
        'NH',
        'NJ',
        'NM',
        'NY',
        'NC',
        'ND',
        'MP',
        'OH',
        'OK',
        'OR',
        'PW',
        'PA',
        'PR',
        'RI',
        'SC',
        'SD',
        'TN',
        'TX',
        'UT',
        'VT',
        'VI',
        'VA',
        'WA',
        'WV',
        'WI',
        'WY'
      )

      IaEligibilityKind = Types::Coercible::String.enum(
        'UnDetermined',
        'Yes',
        'No'
      )

      RelationshipKind = Types::Coercible::String.enum(
        'spouse',
        'domestic_partner',
        'child',
        'parent',
        'sibling',
        'unrelated',
        'aunt_or_uncle',
        'nephew_or_niece',
        'grandchild',
        'grandparent',
        'father_or_mother_in_law',
        'daughter_or_son_in_law',
        'brother_or_sister_in_law',
        'cousin'
      )

      PhoneKind = Types::Coercible::String.enum(
        'home',
        'work',
        'mobile',
        'fax'
      )

      # FosterCare related questions are asked if the age of applicant falls within below range.
      FosterCareRange = (19..25).freeze

      # Student related questions are asked if the age of applicant falls within below range.
      StudentRange = (18..19).freeze

      CsrKind = Types::Coercible::String.enum('0',
                                              '73',
                                              '87',
                                              '94',
                                              '100',
                                              'limited')
    end
    # rubocop:enable Metrics/ModuleLength
  end
end
