# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      module Functions
        # build SSP_ApplicationIndividual__c for IOS transform
        class SspApplicationIndividualCBuilder
          def call(cache)
            @memoized_data = cache
            # TO DO
            # loop through applicants
            # build hash of field mappings
            # return array of transformed SSP_ApplicationIndividual__c hashes
            # [] # mocked return array for initial spec

            # NOTE: uncomment the family members code if data from family member is required
            # family_members = @memoized_data.resolve('family.family_members_hash').item
            application = @memoized_data.resolve('family.magi_medicaid_applications').item
            applicants = application[:applicants]
            applicants.map do |applicant|
              # next unless applicant[:is_applying_coverage] # <- TODO: uncomment (unless we are sending non-applicants?)
              # family_member = family_members.values.detect {|family_member| family_member[:hbx_id] == applicant[:person_hbx_id]}

              {}
            end
          end
        end
      end
    end
  end
end