# frozen_string_literal: true

require 'dry-types'

module AcaEntities
  module MagiMedicaid
    module Mitc

      # Extend DryTypes to include IAP
      module Types
        include Dry.Types
        include Dry::Logic

        DeterminationIndicatorKind = Types::Coercible::String.enum('Y', 'N', 'X')

        CategoryDeterminationKind = Types::Coercible::String.enum('Residency',
                                                                  'Adult Group Category',
                                                                  'Parent Caretaker Category',
                                                                  'Pregnancy Category',
                                                                  'Child Category',
                                                                  'Optional Targeted Low Income Child',
                                                                  'CHIP Targeted Low Income Child',
                                                                  'Unborn Child',
                                                                  'Income Medicaid Eligible',
                                                                  'Income CHIP Eligible',
                                                                  'Medicaid CHIPRA 214',
                                                                  'CHIP CHIPRA 214',
                                                                  'Trafficking Victim',
                                                                  'Seven Year Limit',
                                                                  'Five Year Bar',
                                                                  'Title II Work Quarters Met',
                                                                  'Medicaid Citizen Or Immigrant',
                                                                  'CHIP Citizen Or Immigrant',
                                                                  'Former Foster Care Category',
                                                                  'Work Quarters Override Income',
                                                                  'State Health Benefits CHIP',
                                                                  'CHIP Waiting Period Satisfied',
                                                                  'Dependent Child Covered',
                                                                  'Medicaid Non-MAGI Referral',
                                                                  'Emergency Medicaid',
                                                                  'Refugee Medical Assistance',
                                                                  'APTC Referral')

        RelationshipCodeKind = Types::Coercible::String.enum('01',
                                                             '02',
                                                             '03',
                                                             '04',
                                                             '05',
                                                             '06',
                                                             '07',
                                                             '08',
                                                             '12',
                                                             '13',
                                                             '14',
                                                             '15',
                                                             '16',
                                                             '23',
                                                             '26',
                                                             '27',
                                                             '30',
                                                             '70',
                                                             '87',
                                                             '88')

        RelationshipCodeMap = {
          self: '01',
          husband_or_wife: '02', # spouse
          parent: '03',
          son_or_daughter: '04', # child
          stepson_or_stepdaughter: '05', # stepchild
          grandchild: '06',
          great_grandchild: '06',
          brother_or_sister: '07', # sibling
          domestic_partner: '08',
          stepparent: '12',
          aunt_or_uncle: '13', # uncle_aunt
          nephew_or_niece: '14', # nephew_niece
          grandparent: '15',
          great_grandparent: '15',
          first_cousin: '16', # cousin
          parents_domestic_partner: '17',
          brother_in_law_or_sister_in_law: '23', # sibling_in_law
          son_in_law_or_daughter_in_law: '26', # child_in_law
          former_spouse: '27',
          mother_in_law_or_father_in_law: '30', # parent_in_law
          domestic_partners_child: '70',
          other_relative: '87', # other_relative
          other: '88' # other
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
