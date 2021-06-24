# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A data type for a basis for an assessment of a person's eligibility to participate in a program based on Medicaid household size criteria.
          class MedicaidHouseholdSizeEligibilityBasis
            include HappyMapper
            register_namespace 'hix-ee', 'http://hix.cms.gov/0.1/hix-ee'

            tag 'MedicaidHouseholdSizeEligibilityBasis'
            namespace 'hix-ee'

            # A method of verifying household size.
            element :verification_method, Integer, tag: 'MedicaidHouseholdSizeEligibilityBasisVerificationMethod'

            element :status_indicator, Boolean, tag: 'StatusIndicator', namespace: "ns3"
            element :eligibility_basis_status_code, Boolean, tag: 'EligibilityBasisStatusCode', namespace: "ns5"

            def self.domain_to_mapper(_medicaid_eligibility)
              self.new
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