# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      module Functions
        # build SSP_Relationship__c for IOS transform
        class SspRelationshipCBuilder
          include ::AcaEntities::Operations::Transforms::HashFunctions

          RELATIONSHIPS_MAP = {
            'aunt_or_uncle' => 'AU',
            'child' => 'SD',
            'cousin' => 'OR', # Other Relative
            'grandchild' => 'GSGD',
            'grandparent' => 'GP',
            'nephew_or_niece' => 'NN',
            'parent' => 'PR',
            'sibling' => 'SB',
            'spouse' => 'SP',
            # '' => 'FPR', # Foster Parent
            # '' => 'FSD', # Foster Son/Daughter
            # '' => 'HS', # Half Sibling
            # '' => 'SPR', # Step Parent
            # '' => 'SSB', # Step Sibling
            # '' => 'SSD', # Step Son/Daughter
            # '' => 'UR', # Unrelated
          }.freeze

          def call(cache)
            @memoized_data = cache

            application = @memoized_data.resolve('family.magi_medicaid_applications').item
            applicants = application&.dig(:applicants)
            
            family_members = @memoized_data.resolve('family.family_members_hash').item

            family_members.values.map do |family_member|
              applicant = applicants&.detect { |a| a[:hbx_id] == family_member[:hbx_id] }
              family_member.dig(:person, :person_relationships).map do |relationship|
                {
                  'IsCareTakerToggle__c' => boolean_string(applicant&.dig(:is_primary_caregiver_for)&.include?(relationship[:relative][:hbx_id])),
                  'RelationshipType__c' => RELATIONSHIPS_MAP[relationship[:kind]],
                  'SSP_Member__c' => family_member[:hbx_id],
                  'SSP_MemberRelatedTo__c' => relationship[:relative][:hbx_id]
                }
              end
            end.flatten
          end
        end
      end
    end
  end
end

