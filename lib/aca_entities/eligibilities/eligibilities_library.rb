# frozen_string_literal: true

# Include the baseline entities and contracts of eligibilities

require 'aca_entities/types'
require_relative 'types'

# contracts
require_relative 'contracts/verification_history_contract'
require_relative 'contracts/request_result_contract'
require_relative 'contracts/evidence_item_contract'
require_relative 'contracts/evidence_contract'

# entities
require_relative 'verification_history'
require_relative 'request_result'
require_relative 'evidence_item'
require_relative 'evidence'
