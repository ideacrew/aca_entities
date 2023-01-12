# frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module Contracts
      # Schema and validation rules for the {AcaEntities::InsurancePolicies::InsuranceProduct} entity
      class InsuranceProductContract < Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @return [Dry::Monads::Result::Success] if params pass validation
        # @return [Dry::Monads::Result::Failure] if params fail validation
        params do
          optional(:id).maybe(:string)
          required(:name).value(:string)
          required(:hios_plan_id).value(:string)
          required(:plan_year).value(:integer)
          required(:coverage_type).value(:string)
          required(:metal_level).value(:string)
          required(:market_type).value(:string)
          required(:ehb).maybe(:float)
          optional(:insurance_product_features).array(
            AcaEntities::InsurancePolicies::Contracts::InsuranceProductFeatureContract.params
          )
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
