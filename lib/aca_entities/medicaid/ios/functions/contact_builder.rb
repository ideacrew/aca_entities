# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      module Functions
        # build contact for IOS transform
        class ContactBuilder
          def call(cache)
            @memoized_data = cache
            # TO DO
            # loop through applicants (all or just primary or ???)
            # build hash of field mappings
            # return array of transformed contact hashes
            [] # mocked return array for initial spec
          end
        end
      end
    end
  end
end