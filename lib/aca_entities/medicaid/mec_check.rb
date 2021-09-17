# frozen_string_literal: true

# types
require 'aca_entities/types'
# require_relative 'mec_check/types'

# contracts
require_relative "mec_check/contracts/verify_non_esi_mec_request_contract"
require_relative "mec_check/contracts/non_esi_mec_request_contract"
require_relative "mec_check/contracts/non_esi_mec_individual_information_contract"
require_relative "mec_check/contracts/person_name_contract"
require_relative "mec_check/contracts/requested_insurance_period_contract"

# entities
require_relative "mec_check/requested_insurance_period"
require_relative "mec_check/person_name"
require_relative "mec_check/non_esi_mec_individual_information"
require_relative "mec_check/non_esi_mec_request"
require_relative "mec_check/verify_non_esi_mec_request"

# transformers
require_relative 'mec_check/transformers/person_to_request'

# operations
require_relative 'mec_check/operations/generate_xml'

# happymapper
require 'aca_entities/serializers/xml/medicaid/mec_check'

module AcaEntities
  module Medicaid
    # Domain objects representing Mec Check
    module MecCheck
    end
  end
end
