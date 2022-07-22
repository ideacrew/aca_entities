# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      module Functions
        # build SSP_Relationship__c for IOS transform
        class SspRelationshipCBuilder

          # add these mappings
          # 'Domestic Partner',
          # 'Child ',
          # 'Parent',
          # 'Sibling',
          # 'Unrelated',
          # 'Aunt or Uncle ',
          # 'Nephew or Niece ',
          # 'Grandchild ',
          # 'Grandparent',
          # 'Father or Mother in Law',
          # 'Daughter or son in law',
          # 'Brother or Sister in Law',
          # 'Cousin',
          # 'Domestic Partners child',
          # 'Parents domestic partner'
          RELATIONSHIPS_MAP = {
            'spouse' => 'Spouse'
          }.freeze

          def call(cache)
            @memoized_data = cache
            # TO DO
            #   add all relationship kinds/types to map
            family_members = @memoized_data.resolve('family.family_members_hash').item
            family_members.values.map do |family_member|
              family_member.dig(:person, :person_relationships).map do |relationship|
                {
                  'RelationshipType__c' => relationship[:kind],
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