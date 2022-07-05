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
            #   add relationships kind/type map
            # loop through family member relationships and return array of hashes with type and member
            family_members = @memoized_data.resolve('family.family_members').item
            relationships = family_members.values.map {|family_member| family_member['person']['person_relationships']}.flatten
            relationships.each_with_object([]) do |relationship, collector|
              collector << {
                'RelationshipType__c' => relationship[:kind],
                'SSP_Member__r' => {
                  'IndividualId__c' => relationship['relative']['hbx_id'] # assuming IndividualId__c is family member hbx_id (but it's probably not)
                }
              }
            end
          end
        end
      end
    end
  end
end