# frozen_string_literal: true

module AcaEntities
  module Products
    # external dependencies
    # require 'aca_entities/organizations/issuer_profile_reference'
    # require 'aca_entities/transitions/transitions'

    require_relative 'contracts/event_request_contract'
    require_relative 'contracts/event_response_contract'

    require_relative 'event_request'
    require_relative 'event_response'
  end
end
