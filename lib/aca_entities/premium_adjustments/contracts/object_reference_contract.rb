# frozen_string_literal: true

module AcaEntities
  module PremiumCredits
    module Contracts
      # Schema and validation rules for the {AcaEntities::PremiumCredits::ObjectReference} entity
      class ObjectReferenceContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :identifier unique key to identify the object (optional)
        # @option opts [String] :label class name of the object (optional)
        # @return [Dry::Monads::Result::Success] if params pass validation
        # @return [Dry::Monads::Result::Failure] if params fail validation
        params do
          optional(:identifier).maybe(:string)
          optional(:label).maybe(:string)
        end
      end
    end
  end
end
