# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Entity for Eligibility
      class Eligibility < Dry::Struct
        attribute :csr_eligibility_header, Eligibility::CsrEligibilityHeader.optional.meta(omittable: true)
        attribute :aptc_eligibility_header, Eligibility::AptcEligibilityHeader.optional.meta(omittable: true)

        attribute :chip_citizenship_and_immigration, Eligibility::ChipCitizenshipAndImmigrationBasis.optional.meta(omittable: true)
        attribute :chip_eligibility_header, Eligibility::ChipEligibilityHeader.optional.meta(omittable: true)
        attribute :chip_household_size, Eligibility::ChipHouseholdSizeBasis.optional.meta(omittable: true)
        attribute :chip_incarceration, Eligibility::ChipIncarcerationBasis.optional.meta(omittable: true)
        attribute :chip_income, Eligibility::CsrIncomeBasis.optional.meta(omittable: true)
        attribute :chip_pregnancy_category, Eligibility::ChipPregnancyCategoryBasis.optional.meta(omittable: true)
        attribute :chip_residency, Eligibility::ChipResidencyBasis.optional.meta(omittable: true)
        attribute :chip_ssn_validation, Eligibility::ChipSsnValidationBasis.optional.meta(omittable: true)
        attribute :chip_state_health_benefits, Eligibility::ChipStateHealthBenefitsBasis.optional.meta(omittable: true)
        attribute :chip_targeted_low_income_child, Eligibility::ChipTargetedLowIncomeChildBasis.optional.meta(omittable: true)
        attribute :chip_trafficking_victim, Eligibility::ChipTraffickingVictimBasis.optional.meta(omittable: true)
        attribute :chip_waiting_period, Eligibility::ChipWaitingPeriodBasis.optional.meta(omittable: true)
        attribute :chip_work_quarters_met, Eligibility::ChipWorkQuartersMetBasis.optional.meta(omittable: true)
        attribute :chip_unborn_child_category, Eligibility::ChipUnbornChildCategoryBasis.optional.meta(omittable: true)

        attribute :magi_eligibility_header, Eligibility::MagiEligibilityHeader.optional.meta(omittable: true)
        attribute :magi_chipra214, Eligibility::MagiChip214Basis.optional.meta(omittable: true)
        attribute :magi_targeted_low_income, Eligibility::MagiTargetedLowIncomeBasis.optional.meta(omittable: true)
        attribute :magi_ssn_validation, Eligibility::MagiSsnVAlidationBasis.optional.meta(omittable: true)
        attribute :magi_seven_year_limit, Eligibility::MagiSevenYearLimitBasis.optional.meta(omittable: true)
        attribute :magi_parent_caretaker, Eligibility::MagiParentCaretakerBasis.optional.meta(omittable: true)
        attribute :magi_dependent_child, Eligibility::MagiDependentChildBasis.optional.meta(omittable: true)
        attribute :magi_five_year_bar, Eligibility::CsrEligibilityHeader.optional.meta(omittable: true)
        attribute :magi_adult_group, Eligibility::MagiAdultGroupBasis.optional.meta(omittable: true)
        attribute :magi_adult_group_xx, Eligibility::MagiAdultGroupXxBasis.optional.meta(omittable: true)
        attribute :magi_former_foster_care, Eligibility::FormerFosterCare.optional.meta(omittable: true)
        attribute :magi_citizenship_and_immigration, Eligibility::MagiCitizenshipAndImmigrationBasis.optional.meta(omittable: true)
        attribute :magi_household_size, Eligibility::MagiHouseholdSizeBasis.optional.meta(omittable: true)
        attribute :magi_child_category, Eligibility::MagiChildCategoryBasis.optional.meta(omittable: true)
        attribute :magi_pregnancy, Eligibility::MagiPregnancyBasis.optional.meta(omittable: true)
        attribute :magi_income, Eligibility::MagiIncomeBasis.optional.meta(omittable: true)
        attribute :magi_residency, Eligibility::MagiResidencyBasis.optional.meta(omittable: true)

        attribute :non_magi_eligibility_header, Eligibility::NonMagiEligibilityHeader.optional.meta(omittable: true)
        attribute :non_magi_eligibility, Eligibility::NonMagiEligibilityBasis.optional.meta(omittable: true)

        attribute :emergency_medicaid_residency,
                  Eligibility::EmergencyMedicaidResidencyBasis.optional.meta(omittable: true)
        attribute :emergency_medicaid_eligibility_header,
                  Eligibility::EmergencyMedicaidEligibilityHeader.optional.meta(omittable: true)
        attribute :emergency_medicaid_citizenship_and_immigration,
                  Eligibility::EmergencyMedicaidCitizenshipAndImmigrationBasis.optional.meta(omittable: true)
        attribute :emergency_medicaid_income,
                  Eligibility::EmergencyMedicaidIncomeBasis.optional.meta(omittable: true)

        attribute :exchange_incarceration, Eligibility::ExchangeIncarcerationBasis.optional.meta(omittable: true)
        attribute :exchange_eligibility_header, Eligibility::ExchangeEligibilityHeader.optional.meta(omittable: true)
        attribute :exchange_qhp_residency, Eligibility::ExchangeQhpResidencyBasis.optional.meta(omittable: true)
        attribute :exchange_verified_presence, Eligibility::ExchangeVerifiedPresenceBasis.optional.meta(omittable: true)

        attribute :refugee_medical_assistance_eligibility_header,
                  Eligibility::RefugeeMedicalAssistanceEligibilityHeader.optional.meta(omittable: true)
        attribute :refugee_medical_assistance,
                  Eligibility::EmergencyMedicaidEligibilityHeader.optional.meta(omittable: true)

        attribute :special_enrollment_period, Eligibility::SpecialEnrollmentPeriod.optional.meta(omittable: true)

      end
    end
  end
end
