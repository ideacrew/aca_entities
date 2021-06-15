# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A data type for an assessment of a person's suitability to participate 
          # in a Medicaid program based on criteria other than Modified Adjusted Gross Income (MAGI).
          class MedicaidNonMagiEligibility
            include HappyMapper
            register_namespace 'hix-ee', 'http://hix.cms.gov/0.1/hix-ee'

            tag 'MedicaidNonMAGIEligibility'
            namespace 'hix-ee'

            #A basis for Medicaid non-MAGI Eligibility by reason of eligibility for Medicare.
            has_one :medicare_entitlement_eligibility_basis, MedicaidNonMagiMedicareEntitlementEligibilityBasis

            #A basis for Medicaid non-MAGI Eligibility by reason of blindness or disability.
            has_one :blindness_or_disability_eligibility_basis, MedicaidNonMagiBlindnessOrDisabilityEligibilityBasis

            has_one :eligibility_date_range, EligibilityDateRange

            has_one :eligibility_establishing_system, EligibilityEstablishingSystem

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