# frozen_string_literal: true

# types
require 'aca_entities/types'

############# H92

# contracts
require_relative 'vlp/h92/contracts/passport_country_contract'
require_relative 'vlp/h92/contracts/i327_document_id_contract'
require_relative 'vlp/h92/contracts/i551_document_id_contract'
require_relative 'vlp/h92/contracts/i571_document_id_contract'
require_relative 'vlp/h92/contracts/i766_document_id_contract'
require_relative 'vlp/h92/contracts/cert_of_cit_document_id_contract'
require_relative 'vlp/h92/contracts/natr_of_cert_document_id_contract'
require_relative 'vlp/h92/contracts/mac_read_i551_document_id_contract'
require_relative 'vlp/h92/contracts/temp_i551_document_id_contract'
require_relative 'vlp/h92/contracts/i94_document_id_contract'
require_relative 'vlp/h92/contracts/i94_unexp_foreign_passport_document_id_contract'
require_relative 'vlp/h92/contracts/unexp_foreign_passport_document_id_contract'
require_relative 'vlp/h92/contracts/i20_document_id_contract'
require_relative 'vlp/h92/contracts/ds2019_document_id_contract'
require_relative 'vlp/h92/contracts/other_case1_document_id_contract'
require_relative 'vlp/h92/contracts/other_case2_document_id_contract'
require_relative 'vlp/h92/contracts/dhs_id_contract'
require_relative 'vlp/h92/contracts/initial_verification_request_set_contract'
require_relative 'vlp/h92/contracts/initial_verification_request_contract'
require_relative 'vlp/h92/contracts/sponsorship_data_contract'
require_relative 'vlp/h92/contracts/array_of_sponsorship_data_contract'
require_relative 'vlp/h92/contracts/response_metadata_contract'
require_relative 'vlp/h92/contracts/error_response_metadata_contract'
require_relative 'vlp/h92/contracts/initial_verification_individual_response_set_contract'
require_relative 'vlp/h92/contracts/initial_verification_individual_response_contract'
require_relative 'vlp/h92/contracts/initial_verification_response_set_contract'
require_relative 'vlp/h92/contracts/initial_verification_response_contract'
require_relative 'vlp/h92/contracts/vlp_v37_contract'

# entities
require_relative 'vlp/h92/passport_country'
require_relative 'vlp/h92/i327_document_id'
require_relative 'vlp/h92/i551_document_id'
require_relative 'vlp/h92/i571_document_id'
require_relative 'vlp/h92/i766_document_id'
require_relative 'vlp/h92/cert_of_cit_document_id'
require_relative 'vlp/h92/natr_of_cert_document_id'
require_relative 'vlp/h92/mac_read_i551_document_id'
require_relative 'vlp/h92/temp_i551_document_id'
require_relative 'vlp/h92/i94_document_id'
require_relative 'vlp/h92/i94_unexp_foreign_passport_document_id'
require_relative 'vlp/h92/unexp_foreign_passport_document_id'
require_relative 'vlp/h92/i20_document_id'
require_relative 'vlp/h92/ds2019_document_id'
require_relative 'vlp/h92/other_case1_document_id'
require_relative 'vlp/h92/other_case2_document_id'
require_relative 'vlp/h92/dhs_id'
require_relative 'vlp/h92/initial_verification_request_set'
require_relative 'vlp/h92/initial_verification_request'
require_relative 'vlp/h92/sponsorship_data'
require_relative 'vlp/h92/array_of_sponsorship_data'
require_relative 'vlp/h92/response_metadata'
require_relative 'vlp/h92/error_response_metadata'
require_relative 'vlp/h92/initial_verification_individual_response_set'
require_relative 'vlp/h92/initial_verification_individual_response'
require_relative 'vlp/h92/initial_verification_response_set'
require_relative 'vlp/h92/initial_verification_response'

# operations
require_relative 'vlp/h92/operations/person_to_initial_request'

############# Rx142

# contracts
require_relative 'vlp/rx142/close_case/contracts/error_response_metadata_contract'
require_relative 'vlp/rx142/close_case/contracts/response_metadata_contract'
require_relative 'vlp/rx142/close_case/contracts/close_case_response_set_contract'
require_relative 'vlp/rx142/close_case/contracts/close_case_request_contract'
require_relative 'vlp/rx142/close_case/contracts/close_case_response_contract'

# entities
require_relative 'vlp/rx142/close_case/error_response_metadata'
require_relative 'vlp/rx142/close_case/response_metadata'
require_relative 'vlp/rx142/close_case/close_case_response_set'
require_relative 'vlp/rx142/close_case/close_case_request'
require_relative 'vlp/rx142/close_case/close_case_response'

# operations
require_relative 'vlp/rx142/close_case/operations/verify_close_case_request'
require_relative 'vlp/rx142/close_case/operations/build_close_case_response_params'
require_relative 'vlp/rx142/initial_verification/operations/build_initial_verification_response_params'

# happymapper
require 'aca_entities/serializers/xml/fdsh/vlp'
