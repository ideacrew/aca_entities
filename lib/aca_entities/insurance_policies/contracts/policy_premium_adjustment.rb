# frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module Contracts
      # Schema and validation rules for the {AcaEntities::InsurancePolicies::PolicyPremiumAdjustment} entity
      class PolicyPremiumAdjustmentContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @return [Dry::Monads::Result::Success] if params pass validation
        # @return [Dry::Monads::Result::Failure] if params fail validation
        params do
          optional(:id).value(:string)
          required(:policy_item_premium).value(AcaEntities::InsurancePolicies::Contracts::PolicyItemPremiumContract.params)
          required(:premium_schedule).value(AcaEntities::InsurancePolicies::Contracts::PremiumScheduleContract.params)
          optional(:discount_premium_adjustments).array(AcaEntities::InsurancePolicies::Contracts::AdjustmentTypeContract.params)
          optional(:surcharge_premium_adjustments).array(AcaEntities::InsurancePolicies::Contracts::AdjustmentTypeContract.params)
          optional(:total_discount_premium_amount).value(AcaEntities::Types::Money)
          optional(:total_surcharge_premium_amount).value(AcaEntities::Types::Money)
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
