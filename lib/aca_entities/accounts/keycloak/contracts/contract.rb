# frozen_string_literal: true

require 'dry/validation'

Dry::Validation.load_extensions(:monads)

# Configuration values and shared rules and macros for domain model validation contracts
module AcaEntities
  module Accounts
    module Keycloak
      module Contracts
        # Identities module Contract class (inherits from the {AcaEntities::Contracts::Contract}) top level contract class
        class Contract < AcaEntities::Contracts::Contract
          # config.messages.namespace - custom messages namespace for a contract class. Use this to differentiate common messages
          # def self.validate_nested_contract(key_name, contract_klass, value)
          #   return key.failure(text: "invalid #{key_name}. Expected a hash.") unless value.is_a?(Hash)
          #   result = contract_klass.new.send(:call, value)
          #   result&.failure? ? key.failure(text: "invalid #{key_name}", error: result.errors.to_h) : result.to_h
          # end
        end
      end
    end
  end
end