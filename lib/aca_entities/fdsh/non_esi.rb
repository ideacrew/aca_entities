# frozen_string_literal: true

# types
require 'aca_entities/fdsh/types'
require 'aca_entities/types'

# contracts
require_relative 'non_esi/h31/contracts/insurance_contract'
require_relative 'non_esi/h31/contracts/mec_coverage_contract'
require_relative 'non_esi/h31/contracts/response_metadata_contract'
require_relative 'non_esi/h31/contracts/other_coverage_contract'
require_relative 'non_esi/h31/contracts/applicant_contract'
require_relative 'non_esi/h31/contracts/individual_response_contract'
require_relative 'non_esi/h31/contracts/individual_response_set_contract'
require_relative 'non_esi/h31/contracts/verify_non_esi_mec_response_contract'
require_relative 'non_esi/h31/contracts/organization_code_contract'
require_relative 'non_esi/h31/contracts/organization_contract'
require_relative 'non_esi/h31/contracts/insurance_policy_contract'
require_relative 'non_esi/h31/contracts/individual_request_contract'
require_relative 'non_esi/h31/contracts/verify_non_esi_mec_request_contract'

# entities
require_relative 'non_esi/h31/insurance'
require_relative 'non_esi/h31/mec_coverage'
require_relative 'non_esi/h31/response_metadata'
require_relative 'non_esi/h31/other_coverage'
require_relative 'non_esi/h31/applicant'
require_relative 'non_esi/h31/individual_response'
require_relative 'non_esi/h31/individual_response_set'
require_relative 'non_esi/h31/verify_non_esi_mec_response'
require_relative 'non_esi/h31/organization_code'
require_relative 'non_esi/h31/organization'
require_relative 'non_esi/h31/insurance_policy'
require_relative 'non_esi/h31/individual_request'
require_relative 'non_esi/h31/verify_non_esi_mec_request'

# operations
require_relative 'non_esi/h31/operations/build_non_esi_mec_request'

# happymapper
require 'aca_entities/serializers/xml/fdsh/non_esi'

