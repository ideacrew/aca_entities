# frozen_string_literal: true

# dependencies
# external

require_relative 'types'

# contracts
require_relative 'contracts/contract'
require_relative 'contracts/errors_contract'
require_relative 'contracts/process_state_contract'
require_relative 'contracts/transaction_contract'
require_relative 'contracts/subject_contract'
require_relative 'contracts/transmission_contract'
require_relative 'contracts/job_contract'

# entities
# require_relative 'transaction'
# require_relative 'subject'
require_relative 'transmission'
require_relative 'job'

module AcaEntities
  module Protocols
    # Enttities, contracts and operations that support microservice communication job, transmission, transaction, message and status metadata
    module Transmittable
    end
  end
end
