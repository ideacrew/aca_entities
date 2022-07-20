# frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module Contracts
      # Schema and validation rules for the {AcaEntities::InsurancePolicies::InsuranceProductFeature} entity
      # Example feature key values include: 'pediatric_dental'
      class InsuranceProductFeatureContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @return [Dry::Monads::Result::Success] if params pass validation
        # @return [Dry::Monads::Result::Failure] if params fail validation
        params do
          optional(:id).value(:string)
          required(:key).value(:string)
          required(:title).value(:string)
          optional(:description).value(AcaEntities::Types::StringOrNil)
          optional(:value).value(AcaEntities::Types::Money)
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
