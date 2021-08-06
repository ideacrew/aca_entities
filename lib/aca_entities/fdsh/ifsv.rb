# frozen_string_literal: true

# dependencies
# require_relative 'ridp'
require_relative 'ifsv/h9t/types'

require 'aca_entities/accounts/accounts'

# contracts
require_relative 'ifsv/h9t/contracts/contract'
require_relative 'ifsv/h9t/contracts/api/request_contract'
require_relative 'ifsv/h9t/contracts/fti_applicant_contract'

# entitites
require_relative 'ifsv/h9t/api/response_metadata'
require_relative 'ifsv/h9t/api/error_message'
require_relative 'ifsv/h9t/api/applicant'
require_relative 'ifsv/h9t/api/tax_return'
require_relative 'ifsv/h9t/api/household'
require_relative 'ifsv/h9t/api/response'
require_relative 'ifsv/h9t/api/request'

require_relative 'ifsv/h9t/fti_verification'
require_relative 'ifsv/h9t/fti_applicant'
require_relative 'ifsv/h9t/fti_response_metadata'
# require_relative 'ifsv/h9t/fti_error_message'
require_relative 'ifsv/h9t/fti_response'
require_relative 'ifsv/h9t/request'
