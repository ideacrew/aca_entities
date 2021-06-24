# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A data type for an assessment of a person's suitability to participate in an emergency Medicaid program based on various criteria.
          class MedicaidMagiEligibility
            include HappyMapper
            register_namespace 'hix-ee', 'http://hix.cms.gov/0.1/hix-ee'
            register_namespace 'niem-s', "http://niem.gov/niem/structures/2.0"

            tag 'MedicaidMAGIEligibility'
            namespace 'hix-ee'

            attribute :id, String, namespace: "niem-s"

            has_one :income_eligibility_basis, MedicaidMagiIncomeEligibilityBasis
            has_one :residency_eligibility_basis, MedicaidMagiResidencyEligibilityBasis
            has_one :household_size_eligibility_basis, MedicaidHouseholdSizeEligibilityBasis
            has_one :parent_caretaker_category_eligibility_basis, MedicaidMagiParentCaretakerCategoryEligibilityBasis
            has_one :pregnancy_category_eligibility_basis, MedicaidMagiPregnancyCategoryEligibilityBasis
            has_one :child_category_eligibility_basis, MedicaidMagiChildCategoryEligibilityBasis
            has_one :adult_group_category_eligibility_basis, MedicaidMagiAdultGroupCategoryEligibilityBasis
            has_one :adult_group_xx_category_eligibility_basis, MedicaidMagiAdultGroupXxCategoryEligibilityBasis
            has_one :optional_targeted_low_income_child_eligibility_basis, MedicaidMagiOptionalTargetedLowIncomeChildEligibilityBasis
            has_one :citizen_or_immigrant_eligibility_basis, MedicaidMagiCitizenOrImmigrantEligibilityBasis
            has_one :chipra214_eligibility_basis, MedicaidMagiChipRa214EligibilityBasis
            has_one :seven_year_limit_eligibility_basis, MedicaidMagiSevenYearLimitEligibilityBasis
            has_one :former_foster_care_category_eligibility_basis, MedicaidMagiFormerFosterCareCategoryEligibilityBasis
            has_one :dependent_child_coverage_eligibility_basis, MedicaidMagiDependentChildCoverageEligibilityBasis
            has_one :five_year_bar_eligibility_basis, MedicaidMagiFiveYearBarEligibilityBasis
            has_one :ssn_verification_eligibility_basis, MedicaidMagiSsnVerificationEligibilityBasis
            has_one :eligibility_date_range, EligibilityDateRange
            has_one :eligibility_establishing_system, EligibilityEstablishingSystem

            def self.domain_to_mapper(_medicaid_eligibility)
              self.new
            end

            def to_hash # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
              {
                income_eligibility_basis: income_eligibility_basis&.to_hash,
                residency_eligibility_basis: residency_eligibility_basis&.to_hash,
                household_size_eligibility_basis: household_size_eligibility_basis&.to_hash,
                parent_caretaker_category_eligibility_basis: parent_caretaker_category_eligibility_basis&.to_hash,
                pregnancy_category_eligibility_basis: pregnancy_category_eligibility_basis&.to_hash,
                child_category_eligibility_basis: child_category_eligibility_basis&.to_hash,
                adult_group_category_eligibility_basis: adult_group_category_eligibility_basis&.to_hash,
                adult_group_xx_category_eligibility_basis: adult_group_xx_category_eligibility_basis&.to_hash,
                optional_targeted_low_income_child_eligibility_basis: optional_targeted_low_income_child_eligibility_basis&.to_hash,
                citizen_or_immigrant_eligibility_basis: citizen_or_immigrant_eligibility_basis&.to_hash,
                chipra214_eligibility_basis: chipra214_eligibility_basis&.to_hash,
                seven_year_limit_eligibility_basis: seven_year_limit_eligibility_basis&.to_hash,
                former_foster_care_category_eligibility_basis: former_foster_care_category_eligibility_basis&.to_hash,
                dependent_child_coverage_eligibility_basis: dependent_child_coverage_eligibility_basis&.to_hash,
                five_year_bar_eligibility_basis: five_year_bar_eligibility_basis&.to_hash,
                ssn_verification_eligibility_basis: ssn_verification_eligibility_basis&.to_hash,
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