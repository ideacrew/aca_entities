# frozen_string_literal: true

# types
require 'aca_entities/fdsh/types'
require 'aca_entities/types'

# contracts
require_relative 'contracts/response_metadata_contract'
require_relative 'contracts/document_binary_contract'
require_relative 'contracts/attachment_contract'
require_relative 'contracts/current_income_file_metadata_contract'
require_relative 'contracts/medicare_file_metadata_contract'
require_relative 'contracts/ssa_file_metadata_contract'
require_relative 'contracts/irs_file_metadata_contract'
require_relative 'contracts/service_specific_data_contract'
require_relative 'contracts/transmission_metadata_contract'
require_relative 'contracts/batch_metadata_contract'
require_relative 'contracts/batch_handling_service_request_contract'

# entities
require_relative 'response_metadata'
require_relative 'document_binary'
require_relative 'attachment'
require_relative 'current_income_file_metadata'
require_relative 'medicare_file_metadata'
require_relative 'ssa_file_metadata'
require_relative 'irs_file_metadata'
require_relative 'service_specific_data'
require_relative 'transmission_metadata'
require_relative 'batch_metadata'
require_relative 'batch_handling_service_request'
