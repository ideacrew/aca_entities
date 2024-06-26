# frozen_string_literal: true

# types
require 'aca_entities/fdsh/types'
require 'aca_entities/types'

# contracts
require_relative 'contracts/response_metadata_contract'
require_relative 'contracts/document_binary_contract'
require_relative 'contracts/attachment_contract'
require_relative 'contracts/dmf_file_metadata_contract'
require_relative 'contracts/service_specific_data_contract'
require_relative 'contracts/transmission_metadata_contract'
require_relative 'contracts/batch_metadata_contract'
require_relative 'contracts/batch_handling_service_request_contract'

# entities
require_relative 'request/person_ssn_identification'
require_relative 'request/individual_request'
require_relative 'request/individual_requests'
require_relative 'request/response_metadata'
require_relative 'request/document_binary'
require_relative 'request/attachment'
require_relative 'request/dmf_file_metadata'
require_relative 'request/service_specific_data'
require_relative 'request/transmission_metadata'
require_relative 'request/batch_metadata'
require_relative 'request/batch_handling_service_request'

# operations
require_relative 'operations/generate_individual_xml'
# require_relative 'operations/validate_dmf_manifest_request_payload_xml'
# require_relative 'operations/dmf_manifest_request_to_xml'
