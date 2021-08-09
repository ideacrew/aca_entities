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
require_relative 'ifsv/h9t/contracts/fti_applicant_contract'

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

require_relative 'ifsv/h9t/fti_applicant'
