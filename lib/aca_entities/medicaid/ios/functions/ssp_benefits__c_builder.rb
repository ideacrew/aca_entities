# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      module Functions
        # build SSP_Benefits__c for IOS transform
        class SspBenefitsCBuilder
          def call(cache)
            @memoized_data = cache
            # TO DO
            # loop through benefits
            # build hash of field mappings
            # return array of transformed SSP_Benefits__c hashes
            [] # mocked return array for initial spec
            # application = @memoized_data.resolve('family.magi_medicaid_applications').item
            # applicants = application[:applicants]
            # applicants.map do |applicant|
            #   next unless  applicant[:benefits] && applicant[:benefits].any?
            #   applicant[:benefits].map do |_benefit|
            #     {}
            #   end
            # end.flatten
          end
        end
      end
    end
  end
end