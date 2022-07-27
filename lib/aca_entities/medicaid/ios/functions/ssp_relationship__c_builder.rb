# frozen_string_literal: true

require 'aca_entities/medicaid/ios/types'

module AcaEntities
  module Medicaid
    module Ios
      module Functions
        # build SSP_Relationship__c for IOS transform
        class SspRelationshipCBuilder
          include ::AcaEntities::Operations::Transforms::HashFunctions

          def call(cache)
            @memoized_data = cache

            application = @memoized_data.resolve('family.magi_medicaid_applications').item
            applicants = application&.dig(:applicants)

            family_members = @memoized_data.resolve('family.family_members_hash').item

            family_members.values.map do |family_member|
              applicant = applicants&.detect { |a| a[:hbx_id] == family_member[:hbx_id] }
              family_member.dig(:person, :person_relationships).map do |relationship|
                {
                  # required
                  'RelationshipType__c' => RELATIONSHIPS_MAP[relationship[:kind]],
                  # optional
                  'IsCareTakerToggle__c' => boolean_string(applicant&.dig(:is_primary_caregiver_for)&.include?(relationship[:relative][:hbx_id])),
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

