# frozen_string_literal: true

require 'dry/validation'

Dry::Validation.load_extensions(:monads)

# Configuration values and shared rules and macros for domain model validation contracts
module AcaEntities
  module Eligibilities
    # Ledger module Contract class (inherits from the {AcaEntities::Contracts::Contract}) top level contract class
    class Contract < Dry::Validation::Contract
      # config.messages.namespace - custom messages namespace for a contract class. Use this to differentiate common messages
    end
  end
end
