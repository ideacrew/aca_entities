# frozen_string_literal: true
module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A basis for Medicaid MAGI (Modified Adjusted Gross Income) eligibility 
          # based on optional adult group category rules (subclause (XX) of 42 C.F.R. Section 1902(a)(10)(a)(ii))
          class MedicaidMagiAdultGroupXxCategoryEligibilityBasis
            include HappyMapper
            register_namespace 'hix-ee', 'http://hix.cms.gov/0.1/hix-ee'

            tag 'MedicaidMAGIAdultGroupXXCategoryEligibilityBasis'
            namespace 'hix-ee'

            has_one :status_indicator, StatusIndicator
            has_one :eligibility_basis_status_code, EligibilityBasisStatusCode

            def self.domain_to_mapper(eligibility)
              mapper = self.new
              mapper
            end
          end
        end
      end
    end
  end
end