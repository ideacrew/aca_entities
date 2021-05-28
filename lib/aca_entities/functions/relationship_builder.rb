# frozen_string_literal: true

module AcaEntities
  module Functions
    # builds hash for primary and non primary applicant
    class RelationshipBuilder
      def call(input)
        primary_applicant_id = input.resolve('family.family_members.is_primary_applicant').item
        current_member = input.find(/attestations.members.(\w+)$/).map(&:item).last
        household = input.resolve('attestations.household').item

        relationship = ""
        household[:familyRelationships].each do |a|
          primary_match = a[:no_key][1][:no_key][0] == primary_applicant_id
          current_member_match = a[:no_key][1][:no_key][2] == current_member

          if primary_match && current_member_match
            relationship = a[:no_key][1][:no_key][1]
          else
            next
          end
        end
        [relationship]
      end
    end
  end
end
