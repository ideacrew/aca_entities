# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A data type for an Advance Premium Tax Credit (APTC) eligibility determination outcome
          class AptcEligibility
            include HappyMapper

            tag 'APTCEligibility'
            namespace 'hix-ee'

            # A date range of the eligibility.
            has_one :eligibility_date_range, EligibilityDateRange

            # A system making an eligibility determination.
            has_one :eligibility_establishing_system, EligibilityEstablishingSystem

            def self.domain_to_mapper(eligibility)
              mapper = self.new
              mapper.eligibility_date_range = eligbility.eligibility_date_range
              mapper.eligibility_establishing_system = eligibility.eligibility_establishing_system
              mapper
            end

            def to_hash
              {
                eligibility_date_range: eligibility_date_range.to_hash,
                eligibility_establishing_system: eligibility_establishing_system.to_hash
              }
            end
          end
        end
      end
    end
  end
end