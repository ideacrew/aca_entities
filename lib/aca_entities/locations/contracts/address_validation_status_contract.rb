# frozen_string_literal: true

module AcaEntities
  module Locations
    module Contracts
      # Schema and validation rules for the {AcaEntities::Locations::AddressValidationStatus} entity
      class AddressValidationStatusContract < Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @return [Dry::Monads::Result::Success] if params pass validation
        # @return [Dry::Monads::Result::Failure] if params fail validation
        params do
          optional(:id).value(:string)

          # TODO: change authority to organization/custom type
          required(:authority).value(:string)
          required(:validated_on).value(:date)
          optional(:payload).value(AcaEntities::Types::StringOrNil)
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
