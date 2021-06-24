# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A basis for Medicaid MAGI (Modified Adjusted Gross Income) eligibility based on income rules.
          class MedicaidNonMagiMedicareEntitlementEligibilityBasis
            include HappyMapper

            tag 'MedicaidNonMAGIMedicareEntitlementEligibilityBasis'
            namespace 'hix-ee'

            element :status_indicator, Boolean, tag: 'StatusIndicator', namespace: "ns3"
            element :eligibility_basis_status_code, Boolean, tag: 'EligibilityBasisStatusCode', namespace: "ns5"

            def self.domain_to_mapper(_medicaid_eligibility)
              self.new
            end

            def to_hash
              {
                status_indicator: status_indicator.to_hash,
                eligibility_basis_status_code: eligibility_basis_status_code.to_hash
              }
            end
          end
        end
      end
    end
  end
end