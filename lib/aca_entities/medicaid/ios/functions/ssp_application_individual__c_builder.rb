# frozen_string_literal: true
require 'aca_entities/medicaid/ios/functions/ssp_member__r_builder'

module AcaEntities
  module Medicaid
    module Ios
      module Functions
        # build SSP_ApplicationIndividual__c for IOS transform
        class SspApplicationIndividualCBuilder
          def call(cache)
            @memoized_data = cache
            # NOTE: uncomment the family members code if data from family member is required
            # family_members = @memoized_data.resolve('family.family_members_hash').item
            application = @memoized_data.resolve('family.magi_medicaid_applications').item
            applicants = application[:applicants]
            applicants.map do |applicant|
              # next unless applicant[:is_applying_coverage] # <- TODO: uncomment (unless we are sending non-applicants?)
              # family_member = family_members.values.detect {|family_member| family_member[:hbx_id] == applicant[:person_hbx_id]}
              member_r = AcaEntities::Medicaid::Ios::Functions::SspMemberRBuilder.new.call(applicant)
              {
                :id => applicant[:hbx_id],
                :member__r => member_r
              }
            end
          end
        end
      end
    end
  end
end