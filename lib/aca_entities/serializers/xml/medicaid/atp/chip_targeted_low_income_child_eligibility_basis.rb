# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A basis for Children's Health Insurance Program (CHIP) eligibility based on targeted low-income child rules.
          class ChipTargetedLowIncomeChildEligibilityBasis
            include HappyMapper

            tag 'CHIPTargetedLowIncomeChildEligibilityBasis'
            namespace 'hix-ee'

            # True if the status holds; false otherwise.
            element :status_indicator, Boolean, tag: 'StatusIndicator', namespace: "hix-core"

            # A status of an eligibility basis determination.
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