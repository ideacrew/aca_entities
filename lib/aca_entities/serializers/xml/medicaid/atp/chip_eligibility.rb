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

            # A basis for Medicaid MAGI (Modified Adjusted Gross Income) eligibility based on social security number verification.
            has_one :ssn_verification_eligibility_basis, ChipSsnVerificationEligibilityBasis

            # A basis for Children's Health Insurance Program (CHIP) eligibility based on household size.
            has_one :household_size_eligibility_basis, HouseholdSizeEligibilityBasis

            # A basis for Children's Health Insurance Program (CHIP) eligibility based on incarceration rules.
            has_one :incarceration_eligibility_basis, ChipIncarcerationEligibilityBasis

            # A basis for Children's Health Insurance Program (CHIP) eligibility based on income rules.           
            has_one :income_eligibility_basis, ChipIncomeEligibilityBasis

            # A basis for Children's Health Insurance Program (CHIP) eligibility based on Medicaid residency rules.
            has_one :medicaid_residency_eligibility_basis, ChipMedicaidResidencyEligibilityBasis

            # A basis for Children's Health Insurance Program (CHIP) eligibility based on Medicaid citizen or immigrant rules.            
            has_one :medicaid_citizen_or_immigrant_eligibility_basis, ChipMedicaidCitizenOrImmigrantEligibilityBasis

            # A basis for Children's Health Insurance Program (CHIP) eligibility based on pregnancy category rules.
            has_one :pregnancy_category_eligibility_basis, ChipPregnancyCategoryEligibilityBasis

            # A basis for Children's Health Insurance Program (CHIP) eligibility based on state health benefits rules.
            has_one :state_health_benefits_eligibility_basis, ChipStateHealthBenefitsEligibilityBasis

            # A basis for Children's Health Insurance Program (CHIP) eligibility based on targeted low-income child rules.
            has_one :targeted_low_income_child_eligibility_basis, ChipTargetedLowIncomeChildEligibilityBasis

            # A basis for Children's Health Insurance Program (CHIP) eligibility based on title-II work quarters met section rules.
            has_one :title_ii_workquarters_met_eligibility_basis, ChipTitleIiWorkQuartersMetEligibilityBasis

            # A basis for Children's Health Insurance Program (CHIP) eligibility based on trafficking victim category rules.
            has_one :trafficking_victim_category_eligibility_basis, ChipTraffickingVictimCategoryEligibilityBasis

            # A basis for Children's Health Insurance Program (CHIP) eligibility based on unborn child category rules.
            has_one :unborn_child_category_eligibility_basis, ChipUnbornChildCategoryEligibilityBasis

            # A basis for Children's Health Insurance Program (CHIP) eligibility based on waiting period rules.
            has_one :waiting_period_eligibility_basis, ChipWaitingPeriodEligibilityBasis

            # A date range of the eligibility.
            has_one :eligibility_date_range, EligibilityDateRange

            # A system making an eligibility determination.
            has_one :eligibility_establishing_system, EligibilityEstablishingSystem

            def self.domain_to_mapper(chip_eligibility)
              mapper = self.new
              if chip_eligibility.trafficking_victim_category_eligibility_basis
                mapper.trafficking_victim_category_eligibility_basis =
                  ChipTraffickingVictimCategoryEligibilityBasis.domain_to_mapper(
                    chip_eligibility.trafficking_victim_category_eligibility_basis
                  )
              end
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