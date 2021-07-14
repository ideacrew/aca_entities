# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A data type for a basis for an assessment of a person's eligibility to participate in a program based on Medicaid household size criteria.
          class MedicaidHouseholdSizeEligibilityBasis
            include HappyMapper

            tag 'MedicaidHouseholdSizeEligibilityBasis'
            namespace 'hix-ee'

            # A method of verifying household size.
            element :verification_method, Integer, tag: 'MedicaidHouseholdSizeEligibilityBasisVerificationMethod'

            element :status_indicator, Boolean, tag: 'StatusIndicator', namespace: "hix-core"
            element :eligibility_basis_status_code, Boolean, tag: 'EligibilityBasisStatusCode', namespace: "hix-ee"

            def self.domain_to_mapper(medicaid_eligibility)
              mapper = self.new
              mapper.status_indicator = medicaid_eligibility.status_indicator
              mapper.eligibility_basis_status_code = medicaid_eligibility.eligibility_basis_status_code
              mapper
            end

            def to_hash
              {
                verification_method: verification_method,
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