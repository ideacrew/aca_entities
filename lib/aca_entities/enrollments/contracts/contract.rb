# frozen_string_literal: true

require 'dry/validation'

Dry::Validation.load_extensions(:monads)

# Configuration values and shared rules and macros for domain model validation contracts
module AcaEntities
  module Enrollments
    # Benefit Enrollment Contract class (inherits from the {AcaEntities::Contracts::Contract}) top level contract class
    class Contract < AcaEntities::Contracts::Contract
      # config.messages.namespace - custom messages namespace for a contract class. Use this to differentiate common messages
      # TODO: Uncomment Rules below and add nested validations
      # @!macro rule each
      #   Validates a nested array of $0 params
      #   @!method rule(settings)
      # rule(:tags).each do
      #   if key? && value
      #     result = CallCenter::Validation::TagContract.new.call(value)
      #     # Use dry-validation metadata error form to pass error hash along with text to calling service
      #     key.failure(text: "invalid tags", error: result.errors.to_h) if result && result.failure?
      #   end
      # end
      # rule(:phone_config) do
      #   if key? && value
      #     result = CallCenter::Validation::PhoneConfigContract.new.call(value)
      #     # Use dry-validation metadata error form to pass error hash along with text to calling service
      #     key.failure(text: "invalid phone_config", error: result.errors.to_h) if result && result.failure?
      #   end
      # end
      # rule(:identity_info) do
      #   if key? && value
      #     result = CallCenter::Validation::IdentityInfoContract.new.call(value)
      #     # Use dry-validation metadata error form to pass error hash along with text to calling service
      #     key.failure(text: "invalid identity_info", error: result.errors.to_h) if result && result.failure?
      #   end
      # end
    end
  end
end
