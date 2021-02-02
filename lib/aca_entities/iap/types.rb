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

      ESI_COVERED_KINDS = %w[self self_and_spouse family].freeze

      BenefitNameMap = {}
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

    end
  end
end
