#  frozen_string_literal: true

module AcaEntities
  module Brokers
    module Contracts
      # Schema and validation rules for the {AcaEntities::Brokers::AgentAgencyAssignment} entity
      class AgentAgencyInsurancePolicyAssignmentContract < Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @return [Dry::Monads::Result::Success] if params pass validation
        # @return [Dry::Monads::Result::Failure] if params fail validation
        params do
          optional(:id).value(:string)
          required(:assigned_agent).value(AcaEntities::Brokers::Contracts::AgentAgencyAssignmentContract.params)
          required(:insurance_policy).value(
            AcaEntities::InsurancePolicies::Contracts::IndividualInsurancePolicyContract.params
          )
          required(:start_on).value(:date)
          optional(:end_on).value(:date)
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
