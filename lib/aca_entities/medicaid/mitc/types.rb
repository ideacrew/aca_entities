# frozen_string_literal: true

require 'dry-types'

module AcaEntities
  module Medicaid
    module Mitc

      # Extend DryTypes to include IAP
      module Types
        send(:include, Dry.Types())
        send(:include, Dry::Logic)

        DeterminationIndicatorKind = Types::Coercible::String.enum('Y', 'N', 'X')

        RelationshipCodeKind = Types::Coercible::String.enum('01',
                                                             '02',
                                                             '03',
                                                             '04',
                                                             '05',
                                                             '06',
                                                             '07',
                                                             '12',
                                                             '13',
                                                             '14',
                                                             '15',
                                                             '16',
                                                             '23',
                                                             '26',
                                                             '30',
                                                             '87',
                                                             '88')

        RelationshipCodeMap = {
          self: '01',
          husband_or_wife: '02',
          parent: '03',
          son_or_daughter: '04',
          stepson_or_stepdaughter: '05',
          grandchild: '06',
          great_grandchild: '06',
          brother_or_sister: '07',
          stepparent: '12',
          aunt_or_uncle: '13',
          nephew_or_niece: '14',
          grandparent: '15',
          great_grandparent: '15',
          first_cousin: '16',
          brother_in_law_or_sister_in_law: '23',
          son_in_law_or_daughter_in_law: '26',
          mother_in_law_or_father_in_law: '30',
          other_relative: '87',
          other: '88'
        }.freeze

        YesNoKind = Types::Coercible::String.enum('Y', 'N')

        ImmigrationStatusKind = Types::Coercible::String.enum('01',
                                                              '02',
                                                              '03',
                                                              '04',
                                                              '05',
                                                              '06',
                                                              '07',
                                                              '08',
                                                              '09',
                                                              '10',
                                                              '99')

        ImmigrationStatusCodeMap = {
          'Lawful Permanent Resident (LPR/Green Card Holder)': '01',
          Asylee: '02',
          Refugee: '03',
          'Cuban/Haitian entrant': '04',
          'Paroled into the U.S. for at least one year': '05',
          'Conditional entrant granted before 1980': '06',
          'Battered non-citizen, spouse, child, or parent': '07',
          'Victim of trafficking': '08',
          'Granted withholding of deportation': '09',
          'Member of a federally recognized Indian tribe or American Indian born in Canada': '10',
          Other: '99'
        }.freeze

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
      end

    end
  end
end
