# frozen_string_literal: true

require 'dry-types'

module AcaEntities
  module Iap
    module Mitc

      # Extend DryTypes to include IAP
      module Types
        send(:include, Dry.Types())
        send(:include, Dry::Logic)

        DeterminationIndicatorKind = Types::Coercible::String.enum('Y', 'N', 'X')

        RelationshipCodeKind = Types::Coercible::String.enum(RelationshipCodeMap.values)

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
      end

    end
  end
end
