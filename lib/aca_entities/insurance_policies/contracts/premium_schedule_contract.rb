# frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module Contracts
      # Schema and validation rules for the {AcaEntities::InsurancePolicies::PremiumSchedule} entity
      class PremiumScheduleContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @return [Dry::Monads::Result::Success] if params pass validation
        # @return [Dry::Monads::Result::Failure] if params fail validation
        params do
          optional(:id).value(:string)
          required(:insurance_policy).value(AcaEntities::InsurancePolicies::Contracts::InsurancePolicyContract.params)
          required(:premium_amount).value(AcaEntities::Types::Money)
          required(:insured_begin_on).value(:date)
          required(:insured_end_on).value(:date)
          required(:valid_begin_on).value(:date)
          required(:valid_end_on).value(:date)
          optional(:due_on).value(:date)
          required(:period_type).value(AcaEntities::InsurancePolicies::Contracts::PeriodTypeContract.params)
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
