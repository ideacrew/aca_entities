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
            # loop through applicants (?)
            # call transform on individual applicant
            # return array of transformed applicants
            [] # mocked return array for initial spec
          end
        end
      end
    end
  end
end