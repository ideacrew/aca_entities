# frozen_string_literal: true

require_relative 'contracts/contacts/list_flow_contract'
require_relative 'contracts/contacts/start_outbound_voice_contract'

module AcaEntities
  module CallCenter

    # Define a Contact together with its settings, code hook for dependency injection, and configuration UI attributes
    class Contact < Dry::Struct

    end
  end
end