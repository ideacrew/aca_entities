# frozen_string_literal: true

require 'dry-types'
require 'bigdecimal'

module AcaEntities
  module Medicaid
    module Ios
      # list of iOS mappings
      module Types
        send(:include, Dry.Types)
        send(:include, Dry::Logic)

        GENDER_MAP = {  'female' => 'F', 'male' => 'M' }.freeze

        TAX_KINDS_MAP = {
          # TODO: check on logic for ? mappings
          'dependent' => 'D',
          # ? => 'E'	Dependent of individual not in the household
          'joint' => 'M',
          'separate' => 'S',
          'tax_filer' => 'H',
          'single' => 'H',
          # ? => 'A'	Not Applicable
          'non_filer' => 'I'
        }.freeze

        CONTACT_METHOD_MAP = {
          # TODO: confirm types to use from EA and map to IOS codes
          # below types are from EA
          # ["Email", "Mail", "Text"] => "Paper, Electronic and Text Message communications",
          # ["Email", "Text"] => "Electronic and Text Message communications",
          # ["Email", "Mail"] => "Paper and Electronic communications",
          # ["Mail", "Text"] => "Paper and Text Message communications",
          # ["Text"] => "Only Text Message communication",
          # ["mail"] => "Only Paper communication",
          # ["Email"] => "Only Electronic communications",
        }.freeze

        IMMIGRATION_DOCUMENT_TYPE_CODE_MAP = {
          'Certificate of Citizenship' => 'CC',
          'Cuban/Haitian entrant' => 'CH',
          'DS2019 (Certificate of Eligibility for Exchange Visitor (J-1) Status)' => 'DS',
          'I-327 (Reentry Permit)' => 'RP',
          'I-551 (Permanent Resident Card)' => 'R',
          'I-551 - Permanent Resident Card' => 'R',
          'I-766 (Employment Authorization Card)' => 'EA',
          'I-94 (Arrival/Departure Record)' => 'N',
          'I-94 (Arrival/Departure Record) in Unexpired Foreign Passport' => 'IU',
          'Machine Readable Immigrant Visa (with Temporary I-551 Language)' => 'MR',
          'Certification from U.S. Department of Health and Human Services (HHS) Office of Refugee Resettlement (ORR)' => 'RR',
          'Unexpired Foreign Passport' => 'UP'
        }.freeze

        HISPANIC_MAP = [
          'Mexican', 'Mexican American', 'Chicano/a', 'Puerto Rican', 'Cuban'
        ].freeze

        RACE_MAP = {
          "White" => "WH",
          "Black or African American" => "AA",
          "Asian Indian" => "AI",
          "Chinese" => "CH",
          "Filipino" => "FI",
          "Japanese" => "JA",
          "Korean" => "KO",
          "Vietnamese" => "VI",
          "Other Asian" => "OA",
          "Native Hawaiian" => "HA",
          "Samoan" => "SA",
          "Guamanian or Chamorro" => "GU",
          "Other Pacific Islander" => "OP",
          "American Indian/Alaska Native" => "AI",
          "OTHER" => "Other"
        }.freeze

        FREQUENCY_MAP = {
          # these are placeholder values
          "BI WEEKLY" => "Every 2 Weeks",
          "DAILY" => "Daily",
          "HALF YEARLY" => "Semi-Annually",
          "MONTHLY" => "Monthly",
          "QUARTERLY" => "Quarterly",
          "WEEKLY" => "Weekly",
          "ANNUALLY" => "Annually"
        }.freeze

        EXPENSE_TYPE_MAP = {
          # these are placeholder values
          'alimony_paid' => 'ALIMONY',
          'deductable_part_of_self_employment_taxes' => 'SELFTAX',
          'self_employment_sep_simple_and_qualified_plans' => 'SEP',
          'self_employed_health_insurance' => 'HEALTHINSURANCE',
          'ira_deduction' => 'IRA',
          'reservists_performing_artists_and_fee_basis_government_official_expenses' => 'SPECIAL'
        }.freeze

        INCOME_TYPE_MAP = {
          # these are placeholder values
          'WAGES_AND_SALARIES' => 'JOBINCOMETYPE',
          'INTEREST' => 'UNEARNEDINCOMETYPE',
          'CAPITAL_GAINS' => 'UNEARNEDINCOMETYPE'
        }.freeze

      end
    end
  end
end