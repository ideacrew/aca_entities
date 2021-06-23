# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A data type for an Advance Premium Tax Credit (APTC) eligibility determination outcome
          class AptcEligibility
            include HappyMapper
            register_namespace 'hix-ee', 'http://hix.cms.gov/0.1/hix-ee'

            tag 'APTCEligibility'
            namespace 'hix-ee'

            has_one :eligibility_date_range, EligibilityDateRange
            has_one :eligibility_establishing_system, EligibilityEstablishingSystem

            def self.domain_to_mapper(eligibility)
              mapper = self.new
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