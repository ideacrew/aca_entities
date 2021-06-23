# frozen_string_literal: true
module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A basis for Children's Health Insurance Program (CHIP) eligibility based on social security number verification.
          class ChipSsnVerificationEligibilityBasis
            include HappyMapper
            register_namespace 'hix-ee', 'http://hix.cms.gov/0.1/hix-ee'

            tag 'CHIP-SSNVerificationEligibilityBasis'
            namespace 'hix-ee'

            has_one :status_indicator, StatusIndicator
            has_one :eligibility_basis_status_code, EligibilityBasisStatusCode

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