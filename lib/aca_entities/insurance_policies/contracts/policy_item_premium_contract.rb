# frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module Contracts
      # Schema and validation rules for the {AcaEntities::InsurancePolicies::PolicyItemPremium} entity
      class PolicyItemPremiumContract < Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @return [Dry::Monads::Result::Success] if params pass validation
        # @return [Dry::Monads::Result::Failure] if params fail validation
        params do
          optional(:id).value(:string)
          optional(:premium_schedule_seq_id).value(:integer)
          required(:premium_amount).value(AcaEntities::Types::Money)
          required(:policy_item).value(AcaEntities::InsurancePolicies::Contracts::PolicyItemContract.params)
          required(:insurance_rate).value(AcaEntities::InsurancePolicies::Contracts::InsuranceRateContract.params)
          required(:premium_schedule).value(AcaEntities::InsurancePolicies::Contracts::PremiumScheduleContract.params)
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
