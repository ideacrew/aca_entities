# frozen_string_literal: true

# Include the baseline entities and types
module AcaEntities
  module Libraries
    module IndividualMarketLibrary

      require 'aca_entities/types'

      require 'aca_entities/eligibilities/eligibilities_library'
      require 'aca_entities/magi_medicaid/libraries/iap_library'

      # contracts
      require 'aca_entities/contracts/timestamp_contract'
      require 'aca_entities/contracts/currency_contract'
      require 'aca_entities/contracts/organizations/issuer_profile_reference_contract'
      require 'aca_entities/contracts/products/product_reference_contract'
      require 'aca_entities/contracts/families/family_member_reference_contract'
      require 'aca_entities/contracts/people/person_reference_contract'
      require 'aca_entities/contracts/groups/irs_group_reference_contract'
      require 'aca_entities/contracts/groups/irs_group_contract'
      require 'aca_entities/contracts/events/event_request_contract'
      require 'aca_entities/contracts/events/event_response_contract'
      require 'aca_entities/contracts/documents/document_contract'
      require 'aca_entities/contracts/documents/ridp_document_contract'
      require 'aca_entities/contracts/documents/vlp_document_contract'
      require 'aca_entities/contracts/determinations/individual_market_transition_contract'
      require 'aca_entities/contracts/determinations/eligibility_determination_contract'
      require 'aca_entities/contracts/determinations/product_eligibility_determination_contract'
      require 'aca_entities/contracts/determinations/lawful_presence_determination_contract'
      require 'aca_entities/contracts/people/resident_role_reference_contract'
      require 'aca_entities/contracts/people/consumer_role_reference_contract'
      require 'aca_entities/contracts/benefit_catalogs/benefit_coverage_period_reference_contract'
      require 'aca_entities/contracts/benefit_catalogs/benefit_package_reference_contract'
      require 'aca_entities/contracts/verifications/verification_type_contract'
      require 'aca_entities/contracts/verifications/verification_type_history_element_contract'
      require 'aca_entities/contracts/people/consumer_role_contract'
      require 'aca_entities/contracts/people/resident_role_contract'

      # entities
      require 'aca_entities/timestamp'
      require 'aca_entities/currency'
      require 'aca_entities/organizations/issuer_profile_reference'
      require 'aca_entities/products/product_reference'
      require 'aca_entities/families/family_member_reference'
      require 'aca_entities/people/person_reference'
      require 'aca_entities/groups/irs_group_reference'
      require 'aca_entities/groups/irs_group'
      require 'aca_entities/events/event_request'
      require 'aca_entities/events/event_response'
      require 'aca_entities/documents/document'
      require 'aca_entities/documents/ridp_document'
      require 'aca_entities/documents/vlp_document'
      require 'aca_entities/determinations/individual_market_transition'
      require 'aca_entities/determinations/eligibility_determination'
      require 'aca_entities/determinations/product_eligibility_determination'
      require 'aca_entities/determinations/lawful_presence_determination'
      require 'aca_entities/people/resident_role_reference'
      require 'aca_entities/people/consumer_role_reference'
      require 'aca_entities/benefit_catalogs/benefit_coverage_period_reference'
      require 'aca_entities/benefit_catalogs/benefit_package_reference'
      require 'aca_entities/verifications/verification_type'
      require 'aca_entities/verifications/verification_type_history_element'
      require 'aca_entities/people/consumer_role'
      require 'aca_entities/people/resident_role'
      require 'aca_entities/enrollees/enrollee_demographics'
      require 'aca_entities/enrollees/segment'
      require 'aca_entities/enrollees/enrollee'
      require 'aca_entities/policies/aptc_credit'
      require 'aca_entities/policies/aptc_maximum'
      require 'aca_entities/policies/policy'

      require_relative 'eligibility_library'
      require_relative 'fdsh_library'
      require_relative 'core_library'
    end
  end
end
