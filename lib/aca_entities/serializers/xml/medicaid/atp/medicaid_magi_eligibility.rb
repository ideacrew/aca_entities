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