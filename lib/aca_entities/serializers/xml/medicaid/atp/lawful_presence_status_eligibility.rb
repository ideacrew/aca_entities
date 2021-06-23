# frozen_string_literal: true
module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # 
          class LawfulPresenceStatusEligibility
            include HappyMapper
            register_namespace 'hix-ee', 'http://hix.cms.gov/0.1/hix-ee'

            tag 'LawfulPresenceStatusEligibility'
            namespace 'hix-ee'

            element :status_indicator, Boolean, tag: 'StatusIndicator', namespace: "ns3"
            element :eligibility_basis_status_code, Boolean, tag: 'EligibilityBasisStatusCode', namespace: "ns5"

            def self.domain_to_mapper(medicaid_eligibility)
              mapper = self.new
              mapper
            end

            def to_hash
              {
                status_indicator: status_indicator,
                eligibility_basis_status_code: eligibility_basis_status_code
              }
            end
          end
        end
      end
    end
  end
end