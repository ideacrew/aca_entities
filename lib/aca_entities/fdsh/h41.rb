# frozen_string_literal: true

# types
require 'aca_entities/types'

# contracts
require_relative 'h41/contracts/annual_policy_total_amounts_contract'
require_relative 'h41/contracts/monthly_premium_information_contract'
require_relative 'h41/contracts/recipient_policy_information_contract'
require_relative 'h41/contracts/other_complete_person_name_contract'
require_relative 'h41/contracts/insured_person_contract'
require_relative 'h41/contracts/us_address_group_contract'
require_relative 'h41/contracts/covered_individual_contract'
require_relative 'h41/contracts/coverage_household_group_contract'
require_relative 'h41/contracts/recipient_spouse_contract'
require_relative 'h41/contracts/recipient_contract'
require_relative 'h41/contracts/policy_contract'
require_relative 'h41/contracts/form_1095a_upstream_detail_contract'
require_relative 'h41/contracts/form_1095a_transmission_upstream_contract'
require_relative 'h41/contracts/document_binary_contract'
require_relative 'h41/contracts/attachment_contract'
require_relative 'h41/contracts/batch_metadata_contract'
require_relative 'h41/contracts/transmission_metadata_contract'
require_relative 'h41/contracts/service_specific_data_contract'
require_relative 'h41/contracts/batch_handling_service_request_contract'

# entities
require_relative 'h41/annual_premium_total_amounts'
require_relative 'h41/monthly_premium_information'
require_relative 'h41/recipient_policy_information'
require_relative 'h41/other_complete_person_name'
require_relative 'h41/insured_person'
require_relative 'h41/us_address_group'
require_relative 'h41/covered_individual'
require_relative 'h41/coverage_household_group'
require_relative 'h41/recipient_spouse'
require_relative 'h41/recipient'
require_relative 'h41/policy'
require_relative 'h41/form_1095a_upstream_detail'
require_relative 'h41/form_1095_a_transmission_upstream'
require_relative 'h41/document_binary'
require_relative 'h41/attachment'
require_relative 'h41/batch_metadata'
require_relative 'h41/transmission_metadata'
require_relative 'h41/service_specific_data'
require_relative 'h41/batch_handling_service_request'

# happymapper
require 'aca_entities/serializers/xml/fdsh/h41'
