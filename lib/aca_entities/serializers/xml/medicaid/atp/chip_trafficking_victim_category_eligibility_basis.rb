# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A basis for Children's Health Insurance Program (CHIP) eligibility based on trafficking victim category rules.
          class ChipTraffickingVictimCategoryEligibilityBasis
            include HappyMapper

            tag 'CHIPTraffickingVictimCategoryEligibilityBasis'
            namespace 'hix-ee'

            element :status_indicator, Boolean, tag: 'StatusIndicator', namespace: "hix-core"
            element :eligibility_basis_status_code, Boolean, tag: 'EligibilityBasisStatusCode', namespace: "hix-ee"

            def self.domain_to_mapper(chip_trafficking_victim_category_eb)
              mapper = self.new
              mapper.status_indicator = chip_trafficking_victim_category_eb.status_indicator
              mapper.eligibility_basis_status_code = chip_trafficking_victim_category_eb.eligibility_basis_status_code
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