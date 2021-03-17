# frozen_string_literal: true

module AcaEntities
  # Contract for Eligibility
  class EligibilityContract < Dry::Validation::Contract

    params do
      optional(:csr_eligibility_header).maybe(:hash)
      optional(:aptc_eligibility_header).maybe(:hash)

      optional(:chip_citizenship_and_immigration).maybe(:hash)
      optional(:chip_eligibility_header).maybe(:hash)
      optional(:chip_household_size).maybe(:hash)
      optional(:chip_incarceration).maybe(:hash)
      optional(:chip_income).maybe(:hash)
      optional(:chip_pregnancy_category).maybe(:hash)
      optional(:chip_residency).maybe(:hash)
      optional(:chip_ssn_validation).maybe(:hash)
      optional(:chip_state_health_benefits).maybe(:hash)
      optional(:chip_targeted_low_income_child).maybe(:hash)
      optional(:chip_trafficking_victim).maybe(:hash)
      optional(:chip_waiting_period).maybe(:hash)
      optional(:chip_work_quarters_met).maybe(:hash)
      optional(:chip_unborn_child_category).maybe(:hash)

      optional(:magi_eligibility_header).maybe(:hash)
      optional(:magi_chipra214).maybe(:hash)
      optional(:magi_targeted_low_income).maybe(:hash)
      optional(:magi_ssn_validation).maybe(:hash)
      optional(:magi_seven_year_limit).maybe(:hash)
      optional(:magi_parent_caretaker).maybe(:hash)
      optional(:magi_dependent_child).maybe(:hash)
      optional(:magi_five_year_bar).maybe(:hash)
      optional(:magi_adult_group).maybe(:hash)
      optional(:magi_adult_group_xx).maybe(:hash)
      optional(:magi_former_foster_care).maybe(:hash)
      optional(:magi_citizenship_and_immigration).maybe(:hash)
      optional(:magi_household_size).maybe(:hash)
      optional(:magi_child_category).maybe(:hash)
      optional(:magi_pregnancy).maybe(:hash)
      optional(:magi_income).maybe(:hash)
      optional(:magi_residency).maybe(:hash)

      optional(:non_magi_eligibility_header).maybe(:hash)
      optional(:non_magi_eligibility).maybe(:hash)

      optional(:emergency_medicaid_residency).maybe(:hash)
      optional(:emergency_medicaid_eligibility_header).maybe(:hash)
      optional(:emergency_medicaid_citizenship_and_immigration).maybe(:hash)
      optional(:emergency_medicaid_income).maybe(:hash)

      optional(:exchange_incarceration).maybe(:hash)
      optional(:exchange_eligibility_header).maybe(:hash)
      optional(:exchange_qhp_residency).maybe(:hash)
      optional(:exchange_verified_presence).maybe(:hash)

      optional(:refugee_medical_assistance_eligibility_header).maybe(:hash)
      optional(:refugee_medical_assistance).maybe(:hash)

      optional(:special_enrollment_period).maybe(:hash)
    end
  end
end
