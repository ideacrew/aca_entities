# frozen_string_literal: true

# types
require 'aca_entities/types'
require_relative 'care_first/types'

# contracts
require_relative 'care_first/contracts/pay_now_transfer_payload_contract'

# entities
require_relative 'care_first/pay_now_transfer_payload'

# transformers
require_relative 'care_first/transformers/coverage_and_members'

# operations
require_relative 'care_first/operations/generate_xml'

# happymapper
require 'aca_entities/serializers/xml/pay_now/care_first/pay_now_transfer_payload'

module AcaEntities
  module PayNow
    # Domain objects representing CareFirst custom XML
    module CareFirst
    end
  end
end
