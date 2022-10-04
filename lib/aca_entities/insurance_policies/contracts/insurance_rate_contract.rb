# frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module Contracts
      # Schema and validation rules for the {AcaEntities::InsurancePolicies::InsuranceRate} entity
      class InsuranceRateContract < Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @return [Dry::Monads::Result::Success] if params pass validation
        # @return [Dry::Monads::Result::Failure] if params fail validation
        params do
          optional(:id).value(:string)
          required(:begin_on).value(:date)
          required(:end_on).value(:date)
          required(:rate_amount).value(AcaEntities::Types::Money)
          required(:factor_rates).array(AcaEntities::InsurancePolicies::Contracts::InsuranceRateFactorContract.params)
          required(:risk_rates).array(AcaEntities::InsurancePolicies::Contracts::InsuranceRiskRateContract.params)
        end
      end
    end
  end
end
