# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      module Functions
        # build SSP_InsurancePolicy__c for IOS transform
        class SspInsurancePolicyCBuilder
          def call(cache)
            @memoized_data = cache
            # TO DO
            # loop through benefits (???)
            # build hash of field mappings
            # return array of transformed SSP_InsurancePolicy__c hashes
            [] # mocked return array for initial spec
          end
        end
      end
    end
  end
end