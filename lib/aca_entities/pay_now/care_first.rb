# frozen_string_literal: true

# types
require 'aca_entities/types'
require_relative 'care_first/types'

# contracts
require_relative 'care_first/contracts/coverage_kind_contract'

# entities
require_relative 'care_first/coverage_kind'

# transformers
require_relative 'care_first/transformers/coverage_and_members'

# operations
require_relative 'care_first/operations/generate_xml'

# happymapper
require 'aca_entities/serializers/xml/pay_now/care_first/coverage_kind'

module AcaEntities
  module PayNow
    # Domain objects representing CareFirst custom XML
    module CareFirst
    end
  end
end
