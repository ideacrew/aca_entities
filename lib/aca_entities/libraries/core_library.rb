# frozen_string_literal: true

module AcaEntities
  module Libraries
    # Domain entities and types that make AcaEntities work
    module CoreLibrary
      require 'aca_entities/types'

      require 'aca_entities/contracts/locations/address_contract'
      require 'aca_entities/contracts/contacts/phone_contact_contract'
      require 'aca_entities/contracts/contacts/email_contact_contract'

      require 'aca_entities/contracts/contract'
      require 'aca_entities/contracts/timestamp_contract'
      require 'aca_entities/timestamp'

      require 'aca_entities/contracts/currency_contract'
      require 'aca_entities/currency'

      require 'aca_entities/transitions/contracts/workflow_state_transition_contract'
      require 'aca_entities/transitions/workflow_state_transition'

      require 'aca_entities/app_helper'
      require 'aca_entities/operations/operation'

      require 'aca_entities/events/events'
      require 'aca_entities/documents/documents'

      require 'aca_entities/contracts/identifiers/identifier_kind_contract'
      require 'aca_entities/contracts/identifiers/id_contract'

      # Identities and users
      require 'aca_entities/libraries/identities_library'
      require 'aca_entities/accounts/accounts'

      require 'aca_entities/determinations/determinations'

      require 'aca_entities/people/people'

      require 'aca_entities/contracts/verifications/verification_type_contract'
      require 'aca_entities/contracts/verifications/verification_type_history_element_contract'

      require 'aca_entities/organizations/organizations'

      require 'aca_entities/brokers/brokers'

      require 'aca_entities/contracts/general_agencies/general_agency_account_contract'

      require 'aca_entities/transitions/transitions'

      require 'aca_entities/libraries/attestations_library'

      require 'aca_entities/products/products'

      require 'aca_entities/libraries/eligibility_library'

      require 'aca_entities/evidences/evidences'

      require 'aca_entities/contracts/documents/ridp_document_contract'
      require 'aca_entities/evidences/contracts/ridp_evidence_contract'

      require 'aca_entities/contracts/households/household_reference_contract'
      require 'aca_entities/contracts/households/coverage_household_reference_contract'
      require 'aca_entities/contracts/families/family_reference_contract'
      require 'aca_entities/contracts/families/family_member_reference_contract'

      require 'aca_entities/contracts/qualifying_life_events/qualifying_life_event_kind_reference_contract'
      require 'aca_entities/contracts/enrollment_periods/special_enrollment_period_contract'
      require 'aca_entities/contracts/enrollment_periods/special_enrollment_period_reference_contract'
      require 'aca_entities/contracts/enrollments/hbx_enrollment_exemption_contract'
      require 'aca_entities/contracts/enrollments/hbx_enrollment_member_contract'
      require 'aca_entities/contracts/enrollments/hbx_enrollment_reference_contract'
      require 'aca_entities/contracts/enrollments/hbx_enrollment_contract'

      require 'aca_entities/aptc_csr_eligibilities_enrollments/contracts/accumulator_adjustment_contract'
      require 'aca_entities/aptc_csr_eligibilities_enrollments/contracts/aptc_accumulator_contract'
      require 'aca_entities/aptc_csr_eligibilities_enrollments/contracts/contribution_accumulator_contract'

      require 'aca_entities/contracts/households/coverage_household_member_contract'
      require 'aca_entities/contracts/households/coverage_household_contract'
      require 'aca_entities/contracts/financial/payment_transactions/payment_transaction_contract'

      require 'aca_entities/contracts/enrollees/enrollee_demographics_contract'
      require 'aca_entities/contracts/enrollees/segment_contract'
      require 'aca_entities/contracts/enrollees/enrollee_contract'
      require 'aca_entities/contracts/policies/policy_contract'
      require 'aca_entities/contracts/households/tax_household_member_contract'
      require 'aca_entities/contracts/households/tax_household_contract'
      require 'aca_entities/contracts/households/tax_household_group_contract'
      require 'aca_entities/contracts/households/household_contract'

      require 'aca_entities/contracts/families/family_member_contract'
      require 'aca_entities/contracts/families/family_contract'

      require 'aca_entities/contracts/households/tax_household_reference_contract'
      require 'aca_entities/contracts/premium_credits/tax_household_member_enrollment_member_contract'
      require 'aca_entities/contracts/premium_credits/tax_household_enrollment_contract'

      require 'aca_entities/benefit_markets/types'

      require 'aca_entities/benefit_markets/contracts/application_contract'
      require 'aca_entities/benefit_markets/contracts/pricing_models/member_relationship_contract'
      require 'aca_entities/benefit_markets/contracts/pricing_models/member_relationship_map_contract'
      require 'aca_entities/benefit_markets/contracts/pricing_models/pricing_unit_contract'
      require 'aca_entities/benefit_markets/contracts/pricing_models/pricing_model_contract'
      require 'aca_entities/benefit_markets/contracts/pricing_models/relationship_pricing_unit_contract'
      require 'aca_entities/benefit_markets/contracts/pricing_models/tiered_pricing_unit_contract'
      require 'aca_entities/benefit_markets/contracts/contribution_models/contribution_unit_contract'
      require 'aca_entities/benefit_markets/contracts/contribution_models/contribution_model_contract'
      require 'aca_entities/benefit_markets/contracts/contribution_models/fixed_dollar_contribution_unit_contract'
      require 'aca_entities/benefit_markets/contracts/contribution_models/fixed_percent_contribution_unit_contract'
      require 'aca_entities/benefit_markets/contracts/contribution_models/percent_with_cap_contribution_unit_contract'
      require 'aca_entities/benefit_markets/contracts/locations/county_zip_contract'
      require 'aca_entities/benefit_markets/contracts/locations/rating_area_contract'
      require 'aca_entities/benefit_markets/contracts/locations/service_area_contract'
      require 'aca_entities/benefit_markets/contracts/products/premium_tuple_contract'
      require 'aca_entities/benefit_markets/contracts/products/premium_table_contract'
      require 'aca_entities/benefit_markets/contracts/products/product_reference_contract'
      require 'aca_entities/benefit_markets/contracts/products/product_contract'
      require 'aca_entities/benefit_markets/contracts/products/health_product_contract'
      require 'aca_entities/benefit_markets/contracts/products/dental_product_contract'
      require 'aca_entities/benefit_markets/contracts/products/product_package_contract'
      require 'aca_entities/benefit_markets/contracts/products/legacy_product_package_contract'
      require 'aca_entities/benefit_markets/contracts/benefit_sponsor_catalogs/benefit_sponsor_catalog_contract'

      # entities
      require 'aca_entities/identifiers/identifier_kind'
      require 'aca_entities/identifiers/id'
      require 'aca_entities/evidences/ridp_evidence'
      require 'aca_entities/attestations/ridp_attestation'
      require 'aca_entities/attestations/attestation'

      require 'aca_entities/products/product_reference'
      require 'aca_entities/people/person_reference'
      require 'aca_entities/households/household_reference'
      require 'aca_entities/households/coverage_household_reference'
      require 'aca_entities/families/family_reference'
      require 'aca_entities/families/family_member_reference'
      require 'aca_entities/brokers/broker_role_reference'
      require 'aca_entities/brokers/broker_account'
      require 'aca_entities/brokers/broker_role'
      require 'aca_entities/general_agencies/general_agency_account'
      require 'aca_entities/qualifying_life_events/qualifying_life_event_kind_reference'
      require 'aca_entities/enrollment_periods/special_enrollment_period'
      require 'aca_entities/enrollment_periods/special_enrollment_period_reference'
      require 'aca_entities/enrollments/hbx_enrollment_exemption'
      require 'aca_entities/enrollments/hbx_enrollment_member'

      require 'aca_entities/enrollments/hbx_enrollment_reference'
      require 'aca_entities/enrollments/hbx_enrollment'
      require 'aca_entities/aptc_csr_eligibilities_enrollments/accumulator_adjustment'
      require 'aca_entities/aptc_csr_eligibilities_enrollments/aptc_accumulator'
      require 'aca_entities/aptc_csr_eligibilities_enrollments/contribution_accumulator'
      require 'aca_entities/households/coverage_household_member'
      require 'aca_entities/households/coverage_household'
      require 'aca_entities/financial/payment_transactions/payment_transaction'
      require 'aca_entities/locations/address'
      require 'aca_entities/contacts/phone_contact'
      require 'aca_entities/contacts/email_contact'
      require 'aca_entities/people/person_name'
      require 'aca_entities/people/person_relationship'
      require 'aca_entities/people/person_health'
      require 'aca_entities/people/person_demographics'
      require 'aca_entities/people/person'
      require 'aca_entities/households/tax_household_member'
      require 'aca_entities/households/tax_household'
      require 'aca_entities/households/tax_household_group'
      require 'aca_entities/households/household'
      require 'aca_entities/families/family_member'
      require 'aca_entities/families/family'
      require 'aca_entities/households/tax_household_reference'
      require 'aca_entities/premium_credits/tax_household_member_enrollment_member'
      require 'aca_entities/premium_credits/tax_household_enrollment'
      require 'aca_entities/benefit_markets/document'
      require 'aca_entities/benefit_markets/member_relationship'
      require 'aca_entities/benefit_markets/member_relationship_map'
      require 'aca_entities/benefit_markets/pricing_unit'
      require 'aca_entities/benefit_markets/pricing_model'
      require 'aca_entities/benefit_markets/relationship_pricing_unit'
      require 'aca_entities/benefit_markets/contribution_unit'
      require 'aca_entities/benefit_markets/contribution_model'
      require 'aca_entities/benefit_markets/fixed_dollar_contribution_unit'
      require 'aca_entities/benefit_markets/fixed_percent_contribution_unit'
      require 'aca_entities/benefit_markets/percent_with_cap_contribution_unit'
      require 'aca_entities/benefit_markets/county_zip'
      require 'aca_entities/benefit_markets/rating_area'
      require 'aca_entities/benefit_markets/service_area'
      require 'aca_entities/benefit_markets/tiered_pricing_unit'
      require 'aca_entities/benefit_markets/premium_tuple'
      require 'aca_entities/benefit_markets/premium_table'
      require 'aca_entities/benefit_markets/product_reference'
      require 'aca_entities/benefit_markets/product'
      require 'aca_entities/benefit_markets/health_product'
      require 'aca_entities/benefit_markets/dental_product'
      require 'aca_entities/benefit_markets/product_package'
      require 'aca_entities/benefit_markets/benefit_sponsor_catalog'
      require 'aca_entities/operations/operation'
      require 'aca_entities/async_api/async_api'
    end
  end
end
