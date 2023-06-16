# frozen_string_literal: true

# dependencies
# external

require_relative 'types'

# contracts
require_relative 'contracts/contract'
require_relative 'contracts/error_contract'
require_relative 'contracts/process_state_contract'
require_relative 'contracts/process_status_contract'
require_relative 'contracts/transactions_transmissions_contract'
require_relative 'contracts/transaction_contract'
require_relative 'contracts/subject_contract'
require_relative 'contracts/transmission_contract'
require_relative 'contracts/job_contract'

# entities
require_relative 'errors'
require_relative 'process_state'
require_relative 'process_status'
require_relative 'transactions_transmissions'
require_relative 'transaction'
require_relative 'subject'
require_relative 'transmission'
require_relative 'job'
require_relative 'job_repository'

# operations
require_relative 'operations/transactions/create'
# require_relative 'operations/transactions/update'
# require_relative 'operations/transactions/find'

# require_relative 'operations/transmissions/create'
# require_relative 'operations/transmissions/update'
# require_relative 'operations/transmissions/find'

# require_relative 'operations/process_states/create'
# require_relative 'operations/process_states/update'
# require_relative 'operations/process_states/find'

# require_relative 'operations/process_statuses/create'
# require_relative 'operations/process_statuses/update'
# require_relative 'operations/process_statuses/find'

require_relative 'operations/jobs/find'
require_relative 'operations/jobs/create'
# require_relative 'operations/jobs/update'

# require_relative 'operations/job_repositories/create'

module AcaEntities
  module Protocols
    # Enttities, contracts and operations that support microservice communication job, transmission, transaction, message and status metadata
    module Transmittable
    end
  end
end
