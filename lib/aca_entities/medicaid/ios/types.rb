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

        GENDER_MAP = {
          'female' => 'F',
          'male' => 'M'
        }.freeze

        HISPANIC_MAP = [
          'Mexican', 'Mexican American', 'Chicano/a', 'Puerto Rican', 'Cuban'
        ].freeze

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

        RELATIONSHIPS_MAP = {
          'aunt_or_uncle' => 'AU',
          'child' => 'SD',
          'cousin' => 'OR', # Other Relative
          'grandchild' => 'GSGD',
          'grandparent' => 'GP',
          'nephew_or_niece' => 'NN',
          'parent' => 'PR',
          'sibling' => 'SB',
          'spouse' => 'SP'
          # '' => 'FPR', # Foster Parent
          # '' => 'FSD', # Foster Son/Daughter
          # '' => 'HS', # Half Sibling
          # '' => 'SPR', # Step Parent
          # '' => 'SSB', # Step Sibling
          # '' => 'SSD', # Step Son/Daughter
          # '' => 'UR', # Unrelated
        }.freeze

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

      end
    end
  end
end