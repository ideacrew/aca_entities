# frozen_string_literal: true
module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # An eligibility of a person to receive benefits under the Affordable Care Act. 
          class LawfulPresenceStatusEligibility
            include HappyMapper
            register_namespace 'hix-ee', 'http://hix.cms.gov/0.1/hix-ee'

            tag 'LawfulPresenceStatusEligibility'
            namespace 'hix-ee'

            element :eligibility_indicator, Boolean, tag: 'EligibilityIndicator', namespace: "hix-ee"
            element :eligibility_basis_status_code, String, tag: 'EligibilityBasisStatusCode', namespace: "hix-ee"

            def self.domain_to_mapper(medicaid_eligibility)
              mapper = self.new
              mapper
            end

            def to_hash
              {
                eligibility_indicator: eligibility_indicator,
                eligibility_basis_status_code: eligibility_basis_status_code
              }
            end
          end
        end
      end
    end
  end
end