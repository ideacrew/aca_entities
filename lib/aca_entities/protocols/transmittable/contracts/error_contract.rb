# frozen_string_literal: true

module AcaEntities
  module Protocols
    module Transmittable
      module Contracts
        # Schema and validation rules for the {AcaEntities::Protocols::Transmittable::Errors} entity
        class ErrorContract < Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [Array<AcaEntities::Protocols::Transmittable::Contracts::ErrorsContract.params>]:
          # The list of errors that belong to this object
          # @return [Dry::Monads::Result::Success] if params pass validation
          # @return [Dry::Monads::Result::Failure] if params fail validation
          params do
            optional(:error).maybe(:string)
          end
        end
      end
    end
  end
end