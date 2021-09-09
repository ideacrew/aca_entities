# frozen_string_literal: true

require 'dry-types'
require 'bigdecimal'

module AcaEntities
  # Extend DryTypes
  module Ffe
    # types for MCR transforms
    module Types
      send(:include, Dry.Types)
      send(:include, Dry::Logic)

      DocumentMapping = {
        "REENTRY_PERMIT" => "I-327 (Reentry Permit)",
        "PERMANENT_RESIDENT_CARD_I_551" => "I-551 (Permanent Resident Card)",
        "REFUGEE_TRAVEL_DOCUMENT" => "I-571 (Refugee Travel Document)",
        "EMPLOYMENT_AUTHORIZATION_CARD_I_766" => "I-766 (Employment Authorization Card)",
        "CERTIFICATE_OF_CITIZENSHIP" => "Certificate of Citizenship",
        "CERTIFICATE_OF_NATURALIZATION" => "Naturalization Certificate",
        "MACHINE_READABLE_IMMIGRANT_VISA_WITH_TEMPORARY_I_551_LANGUAGE" => "Machine Readable Immigrant Visa (with Temporary I-551 Language)",
        "TEMPORARY_I_551_STAMP_ON_PASSPORT_OR_I_94_I_94A" => "Temporary I-551 Stamp (on passport or I-94)",
        "ARRIVAL_DEPARTURE_RECORD_IN_FOREIGN_PASSPORT_I_94" => "I-94 (Arrival/Departure Record)",
        "ARRIVAL_DEPARTURE_RECORD_IN_UNEXPIRED_FOREIGN_PASSPORT_I_94" => "I-94 (Arrival/Departure Record) in Unexpired Foreign Passport",
        "FOREIGN_PASSPORT" => "Unexpired Foreign Passport",
        "CERTIFICATE_OF_ELIGIBILITY_FOR_NONIMMIGRANT_STUDENT_STATUS_I_20" =>
              "I-20 (Certificate of Eligibility for Nonimmigrant (F-1) Student Status)",
        "CERTIFICATE_OF_ELIGIBILITY_FOR_EXCHANGE_VISITOR_STATUS_DS_2019" => "DS2019 (Certificate of Eligibility for Exchange Visitor (J-1) Status)",
        "NOTICE_OF_ACTION_I_797_WITH_ALIEN" => "Other (With Alien Number)",
        "NOTICE_OF_ACTION_I_797_I_94" => "Other (With I-94 Number)",
        "OTHER_WITH_ALIEN" => "Other (With Alien Number)",
        "OTHER_WITH_I_94" => "Other (With I-94 Number)"
      }.freeze

      BenefitsKindMapping = {
        INDIVIDUAL_INSURANCE: 'private_individual_and_family_coverage',
        MEDICAID: 'medicaid',
        MEDICARE: 'medicare',
        TRICARE: 'tricare',
        VETERAN_HEALTH_PROGRAM: 'veterans_administration_health_benefits',
        EMPLOYER_SPONSORED: 'employer_sponsored_insurance',
        CHIP: 'child_health_insurance_plan',
        PEACE_CORPS: 'peace_corps_health_benefits'
        # OTHER_FULL_BENEFIT_COVERAGE: 'other_full_benefit_coverage',
        # OTHER_LIMITED_BENEFIT_COVERAGE: 'OTHER_LIMITED_BENEFIT_COVERAGE'
      }.freeze

      HraTypeMapping =
        { ICHRA: "Individual coverage HRA", QSEHRA: "Qualified Small Employer HRA" }.freeze

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

    end
  end
end