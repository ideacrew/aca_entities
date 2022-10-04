# frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module Contracts
      # Schema and validation rules for the {AcaEntities::InsurancePolicies::AdjustmentType} entity
      class AdjustmentTypeContract < Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @return [Dry::Monads::Result::Success] if params pass validation
        # @return [Dry::Monads::Result::Failure] if params fail validation
        params do
          optional(:id).value(:string)
          required(:key).value(:string)
          required(:description).value(:string)
          optional(:adjustment_amount).value(AcaEntities::Types::Money)
          optional(:adjustment_percent).value(:integer, min?: 0, max?: 100)

          # TODO: Reference the authority instance using GUID approach same as EnrollApp EligibilityDetermination code
          optional(:authority_determination_reference).value(:guid)
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end

      # TODO: Create Rule that requires either adjustment_amount or adjustment_percent
    end
  end
end
