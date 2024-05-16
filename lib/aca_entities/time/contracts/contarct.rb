# frozen_string_literal: true

require 'dry/validation'

Dry::Validation.load_extensions(:monads)

# Configuration values and shared rules and macros for domain model validation contracts
module AcaEntities
  module Time
    module Contracts
      # Time module contracts
      class Contract < AcaEntities::Contracts::Contract
        # config.messages.namespace - custom messages namespace for a contract class. Use this to differentiate common messages
      end
    end
  end
end
