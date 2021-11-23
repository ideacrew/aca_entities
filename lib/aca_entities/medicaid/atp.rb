# frozen_string_literal: true

require_relative "atp/types"
require_relative "atp/date"
require_relative "atp/sender"
require_relative "atp/receiver"
require_relative "atp/start_date"
require_relative "atp/end_date"
require_relative "atp/status_valid_date_range"
require_relative "atp/activity_date"
require_relative "atp/income_date"
require_relative "atp/activity_identification"
require_relative "atp/application_identification"
require_relative "atp/transfer_activity"
require_relative "atp/transfer_header"
require_relative "atp/eligibility_date_range"
require_relative "atp/eligibility_determination"
require_relative "atp/eligibility_basis_determination"
require_relative "atp/eligibility_basis"
require_relative "atp/medicaid_magi_ssn_validation_eligibility_basis"
require_relative "atp/chip_medicaid_residency_eligibility_basis"
require_relative "atp/application_update"
require_relative "atp/application_submission"
require_relative "atp/application_creation"
# require_relative "atp/application_identity"
require_relative "atp/verification_date"
require_relative "atp/verification_status"
require_relative "atp/verification_requesting_system"
# require_relative "atp/attestation"
require_relative "atp/role_of_person_reference"
require_relative "atp/income_source_organization_reference"
require_relative "atp/income_earned_date_range"
require_relative "atp/income_payment_frequency"
require_relative "atp/income_frequency"
require_relative "atp/expense_frequency"
require_relative "atp/association_begin_date"
require_relative "atp/association_end_date"
require_relative "atp/insurance_application_assister_reference"
require_relative "atp/insurance_application_assister_association"
require_relative "atp/signature_name"
require_relative "atp/signature_date"
require_relative "atp/signature"
require_relative "atp/authorized_representative_reference"
require_relative "atp/authorized_representative"
require_relative "atp/not_incarcerated_indicator"
require_relative "atp/ssf_attestation"
require_relative "atp/ssf_signer_authorized_representative_association"
require_relative "atp/ssf_primary_contact"
require_relative "atp/ssf_signer"
require_relative "atp/verification_metadata"
require_relative "atp/document_person_identification"
require_relative "atp/document_number"
require_relative "atp/document_expiration_date"
require_relative "atp/immigration_document"
require_relative "atp/lawful_presence_status_eligibility"
require_relative "atp/insurance_applicant_lawful_presence_status"
require_relative 'atp/chip_trafficking_victim_category_eligibility_basis'
require_relative 'atp/chip_incarceration_eligibility_basis'
require_relative 'atp/chip_ssn_verification_eligibility_basis'
require_relative "atp/chip_eligibility"
require_relative "atp/incarceration_date"
require_relative "atp/incarceration"
require_relative "atp/referral_activity_sender_reference"
require_relative "atp/referral_activity_receiver_reference"
require_relative "atp/referral_activity_status"
require_relative "atp/referral_activity"
require_relative "atp/income_compatibility_determination"
require_relative "atp/income_compatibility"
require_relative "atp/medicaid_magi_adult_group_category_eligibility_basis"
require_relative "atp/medicaid_magi_income_eligibility_basis"
require_relative "atp/medicaid_magi_eligibility"
require_relative "atp/chip_identification"
require_relative "atp/medicaid_identification"
require_relative "atp/insurance_member"
require_relative "atp/insurance_policy_applied_effective_date_range"
require_relative "atp/insurance_policy_identification"
require_relative "atp/insurance_premium"
require_relative "atp/insurance_policy"
require_relative "atp/insurance_applicant_non_esi_policy"
require_relative "atp/insurance_applicant"
require_relative "atp/insurance_application"
require_relative "atp/household_member_reference"
# require_relative "atp/household_composition"
require_relative "atp/household_income"
require_relative "atp/medicaid_household"
# # require_relative "atp/address"
# require_relative "atp/citizenship_immigration_status_information"
# require_relative "atp/identifying_information"
# require_relative "atp/identifying_numbers_from_document"
# require_relative "atp/immigration_document"
# require_relative "atp/native_american_information"
# require_relative "atp/employer_sponsored_insurance_information"
# require_relative "atp/lowest_cost_plan"
# require_relative "atp/current_income"
# # require_relative "atp/ssa_income_information"
# require_relative "atp/ssa_information"
# require_relative "atp/ssa_work_quarter"
# require_relative "atp/medicaid_specific_information"
# require_relative "atp/other_insurance_coverage_information"
# require_relative "atp/other_insurance_detail"
# require_relative "atp/person_description_identifier"
# require_relative "atp/coverage_specific_information"
# require_relative "atp/coverage_period"
# require_relative "atp/relationship"
# require_relative "atp/foster_care"
# require_relative "atp/dhs_save"
require_relative "atp/location_street"
require_relative "atp/structured_address"
require_relative "atp/full_telephone"
require_relative "atp/contact_mailing_address"
require_relative "atp/contact_telephone_number"
require_relative "atp/contact_information"
require_relative "atp/person_contact_information_association"
require_relative "atp/person_preferred_language"
require_relative "atp/person_reference"
require_relative "atp/person_association"
require_relative "atp/person_pregnancy_status"
require_relative "atp/person_income"
require_relative "atp/person_expense"
require_relative "atp/tin_identification"
require_relative "atp/tax_dependent"
require_relative "atp/primary_tax_filer"
require_relative "atp/spouse_tax_filer"
require_relative "atp/tax_household"
require_relative "atp/tax_return"
require_relative "atp/organization_augmentation"
require_relative "atp/organization_primary_contact_information"
require_relative "atp/organization_identification"
require_relative "atp/employer"
require_relative "atp/person_ssn_identification"
require_relative "atp/esi_lowest_cost_plan"
require_relative "atp/esi"
require_relative "atp/esi_augmentation"
require_relative "atp/person_employment_association"
require_relative "atp/person_augmentation"
require_relative "atp/tribal_augmentation"
require_relative "atp/person_name"
require_relative "atp/person_birth_date"
require_relative "atp/person_age_measure"
require_relative "atp/person"
require_relative "atp/account_transfer_request"

module AcaEntities
  module Medicaid
    # Domain objects representing Account Transfer Protocol.
    module Atp
    end
  end
end
