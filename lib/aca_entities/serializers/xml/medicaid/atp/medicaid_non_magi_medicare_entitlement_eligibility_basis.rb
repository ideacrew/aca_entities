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
            element :status_code, Boolean, tag: 'EligibilityBasisStatusCode', namespace: "ns5"

            def self.domain_to_mapper(eligibility_basis)
              mapper = self.new
              mapper.status_indicator = eligibility_basis.status_indicator
              mapper.status_code = eligibility_basis.status_code
              mapper
            end

            def to_hash
              {
                status_indicator: status_indicator,
                status_code: status_code
              }
            end
          end
        end
      end
    end
  end
end