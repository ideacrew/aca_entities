# frozen_string_literal: true

# dependencies
# require_relative 'ridp'
require_relative 'ifsv/h9t/types'

require 'aca_entities/accounts/accounts'

# contracts
require_relative 'ifsv/h9t/contracts/contract'
require_relative 'ifsv/h9t/contracts/api/person_contract'
require_relative 'ifsv/h9t/contracts/api/ifsv_applicant_contract'
require_relative 'ifsv/h9t/contracts/api/request_contract'
# require_relative 'ifsv/h9t/contracts/fti_applicant_contract'

require_relative 'ifsv/h9t/contracts/api/fti/response_metadata_contract'
require_relative 'ifsv/h9t/contracts/api/fti/error_message_contract'
require_relative 'ifsv/h9t/contracts/api/fti/tax_return_contract'
require_relative 'ifsv/h9t/contracts/api/fti/verification_contract'
require_relative 'ifsv/h9t/contracts/api/fti/household_contract'
require_relative 'ifsv/h9t/contracts/api/fti/irs_response_contract'
require_relative 'ifsv/h9t/contracts/api/fti/response_contract'

# entitites
require_relative 'ifsv/h9t/api/person'
require_relative 'ifsv/h9t/api/ifsv_applicant'
require_relative 'ifsv/h9t/api/request'

require_relative 'ifsv/h9t/api/fti/response_metadata'
require_relative 'ifsv/h9t/api/fti/error_message'
require_relative 'ifsv/h9t/api/fti/tax_return'
require_relative 'ifsv/h9t/api/fti/verification'
require_relative 'ifsv/h9t/api/fti/household'
require_relative 'ifsv/h9t/api/fti/irs_response'
require_relative 'ifsv/h9t/api/fti/response'

require_relative 'ifsv/h9t/fti/verification'
require_relative 'ifsv/h9t/fti/response_metadata'
require_relative 'ifsv/h9t/fti/response'

# operations
require_relative 'ifsv/h9t/operations/ifsv_verification_request'

# transformers
require_relative 'ifsv/h9t/transformers/ifsv_verification_request_to/persistence_request'
require_relative 'ifsv/h9t/transformers/ifsv_verification_response_to/persistence_response'

# happymapper
require 'aca_entities/serializers/xml/fdsh/ifsv'
