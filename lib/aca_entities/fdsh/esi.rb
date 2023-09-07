# frozen_string_literal: true

# types
require 'aca_entities/types'

# contracts
require_relative 'esi/h14/contracts/date_contract'
require_relative 'esi/h14/contracts/insurance_applicant_requested_coverage_contract'
require_relative 'esi/h14/contracts/insurance_applicant_request_contract'
require_relative 'esi/h14/contracts/request_person_contract'
require_relative 'esi/h14/contracts/applicant_request_contract'
require_relative 'esi/h14/contracts/esi_mec_request_contract'
require_relative 'esi/h14/contracts/insurance_premium_contract'
require_relative 'esi/h14/contracts/monthly_premium_amount_contract'
require_relative 'esi/h14/contracts/insurance_applicant_response_contract'
require_relative 'esi/h14/contracts/applicant_mec_information_contract'
require_relative 'esi/h14/contracts/response_metadata_contract'
require_relative 'esi/h14/contracts/response_person_contract'
require_relative 'esi/h14/contracts/applicant_response_contract'
require_relative 'esi/h14/contracts/applicant_response_set_contract'
require_relative 'esi/h14/contracts/esi_mec_response_contract'

# entities
require_relative 'esi/h14/date'
require_relative 'esi/h14/insurance_applicant_requested_coverage'
require_relative 'esi/h14/insurance_applicant_request'
require_relative 'esi/h14/request_person'
require_relative 'esi/h14/applicant_request'
require_relative 'esi/h14/esi_mec_request'
require_relative 'esi/h14/insurance_premium'
require_relative 'esi/h14/monthly_premium_amount'
require_relative 'esi/h14/insurance_applicant_response'
require_relative 'esi/h14/applicant_mec_information'
require_relative 'esi/h14/response_meta_data'
require_relative 'esi/h14/response_person'
require_relative 'esi/h14/applicant_response'
require_relative 'esi/h14/applicant_response_set'
require_relative 'esi/h14/esi_mec_response'

# operations
require_relative 'esi/rj14/operations/esi_mec_json_request'
require_relative 'esi/h14/operations/build_esi_mec_request'

# happymapper
require 'aca_entities/serializers/xml/fdsh/esi'

