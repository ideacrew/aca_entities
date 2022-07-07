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
          end
        end
      end
    end
  end
end