# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A basis for Children's Health Insurance Program (CHIP) eligibility based on unborn child category rules.
          class ChipUnbornChildCategoryEligibilityBasis
            include HappyMapper

            tag 'CHIPUnbornChildCategoryEligibilityBasis'
            namespace 'hix-ee'

            element :status_indicator, Boolean, tag: 'StatusIndicator', namespace: "hix-core"
            element :eligibility_basis_status_code, Boolean, tag: 'EligibilityBasisStatusCode', namespace: "hix-ee"

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