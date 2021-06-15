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

            #A method of verifying household size.
            element :verification_method, Integer, tag: 'MedicaidHouseholdSizeEligibilityBasisVerificationMethod'

            has_one :status_indicator, StatusIndicator
            has_one :eligibility_basis_status_code, EligibilityBasisStatusCode


            def self.domain_to_mapper(medicaid_eligibility)
              mapper = self.new
              mapper
            end
          end
        end
      end
    end
  end
end