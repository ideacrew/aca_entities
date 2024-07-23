# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A basis for Medicaid MAGI (Modified Adjusted Gross Income) eligibility based on income rules.
          class MedicaidNonMagiMedicareEntitlementEligibilityBasis
            include HappyMapper

            register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'
            register_namespace 'hix-ee', 'http://hix.cms.gov/0.1/hix-ee'

            tag 'MedicaidNonMAGIMedicareEntitlementEligibilityBasis'
            namespace 'hix-ee'

            element :status_indicator, Boolean, tag: 'StatusIndicator', namespace: "hix-core"
            element :status_code, Boolean, tag: 'EligibilityBasisStatusCode', namespace: "hix-ee"

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