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

            tag 'MedicaidNonMAGIEligibility'
            namespace 'hix-ee'

            attribute :id, String, namespace: "niem-s"

            # A basis for Medicaid non-MAGI Eligibility by reason of eligibility for Medicare.
            has_one :medicare_entitlement_eligibility_basis, MedicaidNonMagiMedicareEntitlementEligibilityBasis

            # A basis for Medicaid non-MAGI Eligibility by reason of blindness or disability.
            has_one :blindness_or_disability_eligibility_basis, MedicaidNonMagiBlindnessOrDisabilityEligibilityBasis

            has_one :eligibility_date_range, EligibilityDateRange

            has_one :eligibility_establishing_system, EligibilityEstablishingSystem

            def self.domain_to_mapper(non_magi_eligibility)
              mapper = self.new
              mapper.id = non_magi_eligibility.id
              mapper.medicare_entitlement_eligibility_basis = non_magi_eligibility.medicare_entitlement_eligibility_basis
              mapper.blindness_or_disability_eligibility_basis = non_magi_eligibility.blindness_or_disability_eligibility_basis
              mapper.eligibility_date_range = non_magi_eligibility.eligibility_date_range
              mapper.eligibility_establishing_system = non_magi_eligibility.eligibility_establishing_system
              mapper
            end

            def to_hash
              {
                medicare_entitlement_eligibility_basis: medicare_entitlement_eligibility_basis&.to_hash,
                blindness_or_disability_eligibility_basis: blindness_or_disability_eligibility_basis&.to_hash,
                eligibility_date_range: eligibility_date_range&.to_hash,
                eligibility_establishing_system: eligibility_establishing_system&.to_hash
              }
            end
          end
        end
      end
    end
  end
end