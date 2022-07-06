# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      module Functions
        # build SSP_Asset__c for IOS transform
        class SspAssetCBuilder
          def call(cache)
            @memoized_data = cache
            # TO DO
            # loop through ??
            # call transform on individual elements
            # return array of transformed elements
            [] # mocked return array for initial spec
          end
        end
      end
    end
  end
end