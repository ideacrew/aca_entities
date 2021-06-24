# frozen_string_literal: true

require "happymapper"

require_relative "atp/role_of_person_reference"
require_relative "atp/signature"
require_relative "atp/eligibility_establishing_system"
require_relative "atp/end_date"
require_relative "atp/start_date"
require_relative "atp/status_valid_date_range"
require_relative "atp/insurance_applicant_esi_planned_coverage_date_range"
require_relative "atp/status_indicator"
require_relative "atp/activity_identification"
require_relative "atp/activity_date"
require_relative "atp/full_telephone"
require_relative "atp/street"
require_relative "atp/structured_address"
require_relative "atp/elgibility_date_range"
require_relative "atp/eligibility_basis_status_code"
require_relative "atp/association_begin_date"
require_relative "atp/association_end_date"
require_relative "atp/contact_information"
require_relative "atp/organization_primary_contact_information"
require_relative "atp/organization"
require_relative "atp/employer"
require_relative "atp/expense_frequency"
require_relative "atp/income_date"
require_relative "atp/income_earned_date_range"
require_relative "atp/income_frequency"
require_relative "atp/income_payment_frequency"
require_relative "atp/income_source_organization_reference"
require_relative "atp/birth_date"
require_relative "atp/tribal_augmentation"
require_relative "atp/person_reference"
require_relative "atp/person_association"
require_relative "atp/person_chip_identification"
require_relative "atp/person_contact_information_association"
require_relative "atp/person_employment_association"
require_relative "atp/person_expense"
require_relative "atp/person_income"
require_relative "atp/person_medicaid_identification"
require_relative "atp/person_preferred_language"
require_relative "atp/person_pregnancy_status"
require_relative "atp/person_augmentation"
require_relative "atp/household_member_reference"
require_relative "atp/physical_household"
require_relative "atp/insurance_application_assister_association"
require_relative "atp/referral_activity_eligibility_reason_reference"
require_relative "atp/referral_activity_receiver_reference"
require_relative "atp/referral_activity_sender_reference"
require_relative "atp/referral_activity_status"
require_relative "atp/referral_activity"
require_relative "atp/lawful_presence_status_eligibility"
require_relative "atp/insurance_applicant_lawful_presence_status"
require_relative "atp/household_size_eligibility_basis"
require_relative "atp/chip_incarceration_eligibility_basis"
require_relative "atp/chip_income_eligibility_basis"
require_relative "atp/chip_medicaid_citizen_or_immigrant_eligibility_basis"
require_relative "atp/chip_medicaid_residency_eligibility_basis"
require_relative "atp/chip_pregnancy_category_eligibility_basis"
require_relative "atp/chip_ssn_verification_eligibility_basis"
require_relative "atp/chip_state_health_benefits_eligibility_basis"
require_relative "atp/chip_targeted_low_income_child_eligibility_basis"
require_relative "atp/chip_title_ii_work_quarters_met_eligibility_basis"
require_relative "atp/chip_trafficking_victim_category_eligibility_basis"
require_relative "atp/chip_unborn_child_category_eligibility_basis"
require_relative "atp/chip_waiting_period_eligibility_basis"
require_relative "atp/chip_eligibility"
require_relative "atp/csr_eligibility"
require_relative "atp/exchange_eligibility"
require_relative "atp/aptc_eligibility"
require_relative "atp/insurance_policy_identification"
require_relative "atp/insurance_applicant_non_esi_policy"
require_relative "atp/medicaid_magi_residency_eligibility_basis"
require_relative "atp/medicaid_magi_parent_caretaker_category_eligibility_basis"
require_relative "atp/medicaid_magi_pregnancy_category_eligibility_basis"
require_relative "atp/medicaid_magi_child_category_eligibility_basis"
require_relative "atp/medicaid_magi_adult_group_category_eligibility_basis"
require_relative "atp/medicaid_magi_adult_group_xx_category_eligibility_basis"
require_relative "atp/medicaid_magi_chip_ra214_eligibility_basis"
require_relative "atp/medicaid_magi_citizen_or_immigrant_eligibility_basis"
require_relative "atp/medicaid_magi_dependent_child_coverage_eligibility_basis"
require_relative "atp/medicaid_magi_five_year_bar_eligibility_basis"
require_relative "atp/medicaid_magi_former_foster_care_category_eligibility_basis"
require_relative "atp/medicaid_magi_income_eligibility_basis"
require_relative "atp/medicaid_magi_optional_targeted_low_income_child_eligibility_basis"
require_relative "atp/medicaid_household_size_eligibility_basis"
require_relative "atp/medicaid_magi_seven_year_limit_eligibility_basis"
require_relative "atp/medicaid_magi_ssn_verification_eligibility_basis"
require_relative "atp/medicaid_non_magi_blindness_or_disability_eligibility_basis"
require_relative "atp/medicaid_non_magi_medicare_entitlement_eligibility_basis"
require_relative "atp/medicaid_non_magi_eligibilities"
require_relative "atp/transfer_activity"
require_relative "atp/transfer_header"
require_relative "atp/sender"
require_relative "atp/receiver"
require_relative "atp/application_creation"
require_relative "atp/application_submission"
require_relative "atp/application_identification"
require_relative "atp/insurance_policy"
require_relative "atp/esi_association"
require_relative "atp/person_name"
require_relative "atp/role_played_by_person"
require_relative "atp/authorized_representative_reference"
require_relative "atp/authorized_representative"
require_relative "atp/ssf_attestation"
require_relative "atp/ssf_primary_contact"
require_relative "atp/ssf_signer_authorized_representative_association"
require_relative "atp/ssf_signer"
require_relative "atp/emergency_medicaid_citizen_or_immigrant_eligibility_basis"
require_relative "atp/emergency_medicaid_income_eligibility_basis"
require_relative "atp/emergency_medicaid_residency_eligibility_basis"
require_relative "atp/medicaid_household"
require_relative "atp/medicaid_magi_eligibility"
require_relative "atp/emergency_medicaid_eligibility"
require_relative "atp/insurance_applicant"
require_relative "atp/insurance_application"
require_relative "atp/person"
require_relative "atp/assister"
require_relative "atp/account_transfer_request"

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        # XML serialization for Account Transfer Protocol (ATP) objects.
        module Atp
        end
      end
    end
  end
end