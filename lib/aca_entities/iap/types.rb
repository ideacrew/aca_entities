# frozen_string_literal: true

require 'dry-types'

module AcaEntities
  module Iap

    # Extend DryTypes to include IAP
    module Types
      send(:include, Dry.Types())
      send(:include, Dry::Logic)

      BenefitKind = Types::Coerccable::String.enum(
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
        'peace_corps_health_benefits',
      )

      BenefitStatusKind = Types::Coerccable::String.enum('is_eligible', 'is_enrolled')
      EsiCoveredKind    = Types::Coerccable::String.enum('self', 'self_and_spouse', 'family')

      DriverQuestionAttributeKind = Types::Coerccable::String.enum(
        'has_job_income',
        'has_self_employment_income',
        'has_other_income',
        'has_deductions',
        'has_enrolled_health_coverage',
        'has_eligible_health_coverage',
      )

      IncomeValidationStateKind   = Types::Coerccable::String.enum('na', 'valid', 'outstanding', 'pending')
      MecValidationStateKind      = Types::Coerccable::String.enum('na', 'valid', 'outstanding', 'pending')
      NaturalizationDocumentKind  = Types::Coerccable::String.enum('Certificate of Citizenship', 'Naturalization Certificate')

      StudentKind   = Types::Coerccable::String.enum(
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
        'vocational_tech',
      )

      StudentSchoolKind = Types::Coerccable::String.enum(
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
        'vocational',
      )

      TaxFilerKind  = Types::Coerccable::String.enum('tax_filer', 'single', 'joint', 'separate', 'dependent', 'non_filer')

      # List of the documents user can provide to verify Immigration status
      VlpDocumentKind = Types::Coerccable::String.enum(
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

      BenefitTermMap = {}
      INSURANCE_TYPE = {
        acf_refugee_medical_assistance: 'ACF Refugee Medical Assistance',
        americorps_health_benefits: 'AmeriCorps health benefits',
        child_health_insurance_plan: "Children's Health Insurance Program",
        medicaid: 'Medicaid',
        medicare: 'Medicare',
        medicare_advantage: 'Medicare Advantage',
        medicare_part_b: 'Medicare Part B',
        private_individual_and_family_coverage: 'Private individual and family coverage',
        state_supplementary_payment: 'State Supplementary Payment',
        tricare: 'TRICARE',
        veterans_benefits: 'Veterans benefits',
        naf_health_benefit_program: 'NAF Health Benefits Program',
        health_care_for_peace_corp_volunteers: 'Health care for Peace Corps volunteers',
        department_of_defense_non_appropriated_health_benefits: 'Department of Defense Nonappropriated Fund health benefits',
        cobra: 'COBRA',
        employer_sponsored_insurance: 'Employer-sponsored insurance',
        self_funded_student_health_coverage: 'Self-funded student health coverage',
        foreign_government_health_coverage: 'Foreign government health coverage',
        private_health_insurance_plan: 'Private health insurance plan',
        coverage_obtained_through_another_exchange: 'Coverage obtained through another exchange',
        coverage_under_the_state_health_benefits_risk_pool: 'Coverage under the state health benefits risk pool',
        veterans_administration_health_benefits: 'Veterans Administration health benefits',
        peace_corps_health_benefits: 'Peace Corps health benefits'
      }.freeze

      CitizenTermMap = {
        us_citizen: 'US citizen',
        naturalized_citizen: 'Naturalized citizen',
        alien_lawfully_present: 'Alien lawfully present',
        lawful_permanent_resident: 'Lawful permanent resident',
        undocumented_immigrant: 'Undocumented immigrant',
        not_lawfully_present_in_us: 'Not lawfully present in US',
        non_native_not_lawfully_present_in_us: 'Non-native not lawfully present in US',
        ssn_pass_citizenship_fails_with_SSA: 'SSN pass citizenship fails with SSA',
        non_native_citizen: 'Non-native citizen'
      }

    end
  end
end
