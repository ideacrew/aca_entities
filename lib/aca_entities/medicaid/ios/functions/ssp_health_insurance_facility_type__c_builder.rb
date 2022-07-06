# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      module Functions
        # build SSP_HealthInsuranceFacilityType__c for IOS transform
        class SspHealthInsuranceFacilityTypeCBuilder
          def call(cache)
            @memoized_data = cache
            # TO DO
            # loop through benefits(???)
            # call transform on individual benefits
            # return array of transformed benefits
            [] # mocked return array for initial spec
          end
        end
      end
    end
  end
end