# frozen_string_literal: true

module AcaEntities
  module Locations
    module Addresses
      module Contracts
        # Schema and validation rules for the {AcaEntities::Locations::Addresses::ValidationStatus} entity
        class ValidationStatusContract < Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @return [Dry::Monads::Result::Success] if params pass validation
          # @return [Dry::Monads::Result::Failure] if params fail validation
          params do
            optional(:id).value(:string)

            # TODO: change authority to organization/custom type
            required(:authority).value(:string)
            optional(:payload).value(AcaEntities::Locations::Types::StringOrNil)
            required(:validated_at).value(:date_time)
            optional(:timestamps).hash(AcaEntities::Contracts::TimeStampContract.params)
          end
        end
      end
    end
  end
end
