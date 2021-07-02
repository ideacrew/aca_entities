# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A data type for an assessment of a person's suitability to participate
          # in a Children's Health Insurance Program (CHIP) program based on various criteria.
          class ChipEligibility
            include HappyMapper

            tag 'CHIPEligibility'
            namespace 'hix-ee'

            has_one :ssn_verification_eligibility_basis, ChipSsnVerificationEligibilityBasis
            has_one :household_size_eligibility_basis, HouseholdSizeEligibilityBasis
            has_one :incarceration_eligibility_basis, ChipIncarcerationEligibilityBasis
            has_one :income_eligibility_basis, ChipIncomeEligibilityBasis
            has_one :medicaid_residency_eligibility_basis, ChipMedicaidResidencyEligibilityBasis
            has_one :medicaid_citizen_or_immigrant_eligibility_basis, ChipMedicaidCitizenOrImmigrantEligibilityBasis
            has_one :pregnancy_category_eligibility_basis, ChipPregnancyCategoryEligibilityBasis
            has_one :state_health_benefits_eligibility_basis, ChipStateHealthBenefitsEligibilityBasis
            has_one :targeted_low_income_child_eligibility_basis, ChipTargetedLowIncomeChildEligibilityBasis
            has_one :title_ii_workquarters_met_eligibility_basis, ChipTitleIiWorkQuartersMetEligibilityBasis
            has_one :trafficking_victim_category_eligibility_basis, ChipTraffickingVictimCategoryEligibilityBasis
            has_one :unborn_child_category_eligibility_basis, ChipUnbornChildCategoryEligibilityBasis
            has_one :waiting_period_eligibility_basis, ChipWaitingPeriodEligibilityBasis
            has_one :eligibility_date_range, EligibilityDateRange
            has_one :eligibility_establishing_system, EligibilityEstablishingSystem

            def self.domain_to_mapper(chip_eligibility)
              mapper = self.new
              mapper.trafficking_victim_category_eligibility_basis = 
                ChipTraffickingVictimCategoryEligibilityBasis.domain_to_mapper(
                  chip_eligibility.trafficking_victim_category_eligibility_basis
                )
              mapper
            end

            def to_hash # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
              {
                ssn_verification_eligibility_basis: ssn_verification_eligibility_basis&.to_hash,
                household_size_eligibility_basis: household_size_eligibility_basis&.to_hash,
                incarceration_eligibility_basis: incarceration_eligibility_basis&.to_hash,
                income_eligibility_basis: income_eligibility_basis&.to_hash,
                medicaid_residency_eligibility_basis: medicaid_residency_eligibility_basis&.to_hash,
                medicaid_citizen_or_immigrant_eligibility_basis: medicaid_citizen_or_immigrant_eligibility_basis&.to_hash,
                pregnancy_category_eligibility_basis: pregnancy_category_eligibility_basis&.to_hash,
                state_health_benefits_eligibility_basis: state_health_benefits_eligibility_basis&.to_hash,
                targeted_low_income_child_eligibility_basis: targeted_low_income_child_eligibility_basis&.to_hash,
                title_ii_workquarters_met_eligibility_basis: title_ii_workquarters_met_eligibility_basis&.to_hash,
                trafficking_victim_category_eligibility_basis: trafficking_victim_category_eligibility_basis&.to_hash,
                unborn_child_category_eligibility_basis: unborn_child_category_eligibility_basis&.to_hash,
                waiting_period_eligibility_basis: waiting_period_eligibility_basis&.to_hash,
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