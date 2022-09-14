# frozen_string_literal: true

require 'dry/validation'

Dry::Validation.load_extensions(:monads)

# Configuration values and shared rules and macros for domain model validation contracts
module AcaEntities
  module Identities
    module Contracts
      # Identities module Contract class (inherits from the {AcaEntities::Contracts::Contract}) top level contract class
      class Contract < AcaEntities::Contracts::Contract
        # config.messages.namespace - custom messages namespace for a contract class. Use this to differentiate common messages

        # Return results from using a contract to validate and coerce nested parameters
        # When called from a param block using :value_coercer it will properly return recursive nested data values or
        # error messages.
        # @return [Dry::Schema::Result]
        # @example
        #   my_contract.rb
        #
        #   MyContract < Contract
        #     params do
        #       required(:subscriber).value(:hash)
        #
        #       before(:value_coercer) do |result|
        #         validated_vals = validate_subscriber(:subscriber, EnrolledMemberContract, result.to_h)
        #         result_hash.to_h.merge(validated_vals.to_h).compact
        #       end
        #
        #       def validate_subscriber(:subscriber, EnrolledMemberContract, result.to_h, values)
        #         key_name = key.to_s
        #         value = values[key_name.to_sym]
        #         validate_nested_contract(key_name, contract_klass, value)
        #       end
        #     end
        #
        #   end
        def self.validate_nested_contract(key_name, contract_klass, value)
          return key.failure(text: "invalid #{key_name}. Expected a hash.") unless value.is_a?(Hash)
          result = contract_klass.new.send(:call, value)
          result&.failure? ? key.failure(text: "invalid #{key_name}", error: result.errors.to_h) : result.to_h
        end
      end
    end
  end
end
