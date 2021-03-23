# frozen_string_literal: true

require 'dry-types'

module AcaEntities
  module Iap

    # Extend DryTypes to include IAP
    module Types
      send(:include, Dry.Types())
      send(:include, Dry::Logic)

      VersionKind = Types::Coercible::String.default('0.1.0').enum('0.1.0')

      BenefitKind = Types::Coercible::String.enum(
        'acf_refugee_medical_assistance',
        'americorps_health_benefits',
        'child_health_insurance_plan',
        'medicaid',
        'medicare',
        'medicare_advantage',
        'medicare_part_b',
        'private_individual_and_family_coverage',
        'state_supplementary_payment',
        'tricare',
        'veterans_benefits',
        'naf_health_benefit_program',
        'health_care_for_peace_corp_volunteers',
        'department_of_defense_non_appropriated_health_benefits',
        'cobra',
        'employer_sponsored_insurance',
        'self_funded_student_health_coverage',
        'foreign_government_health_coverage',
        'private_health_insurance_plan',
        'coverage_obtained_through_another_exchange',
        'coverage_under_the_state_health_benefits_risk_pool',
        'veterans_administration_health_benefits',
        'peace_corps_health_benefits'
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
        'scholorship_payments',
        'social_security_benefit',
        'supplemental_security_income',
        'tax_exempt_interest',
        'unemployment_insurance',
        'wages_and_salaries',
        'income_from_irs'
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
        'Once'
      )

      DeductionFrequency = IncomeFrequency

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
    end
  end
end