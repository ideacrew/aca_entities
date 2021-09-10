# frozen_string_literal: true

# types
require 'aca_entities/fdsh/types'
require 'aca_entities/types'

# contracts
require_relative 'rrv/medicare/contracts/insurance_contract'
require_relative 'rrv/medicare/contracts/individual_response_contract'
require_relative 'rrv/medicare/contracts/ees_dsh_batch_response_data_contract'
require_relative 'rrv/medicare/contracts/insurance_policy_contract'
require_relative 'rrv/medicare/contracts/applicant_contract'
require_relative 'rrv/medicare/contracts/individual_request_contract'
require_relative 'rrv/medicare/contracts/ees_dsh_batch_request_data_contract'

# entities
require_relative 'rrv/medicare/insurance'
require_relative 'rrv/medicare/individual_response'
require_relative 'rrv/medicare/ees_dsh_batch_response_data'
require_relative 'rrv/medicare/insurance_policy'
require_relative 'rrv/medicare/applicant'
require_relative 'rrv/medicare/individual_request'
require_relative 'rrv/medicare/ees_dsh_batch_request_data'

# operations
require_relative 'rrv/medicare/operations/build_medicare_request'

# happymapper
require 'aca_entities/serializers/xml/fdsh/rrv'