#  frozen_string_literal: true

module AcaEntities
  module Brokers
    module Contracts
      # Schema and validation rules for the {AcaEntities::InsurancePolicies::InsuranceProvider} entity
      class AgentAgencyAssignmentContract < Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @return [Dry::Monads::Result::Success] if params pass validation
        # @return [Dry::Monads::Result::Failure] if params fail validation
        params do
          optional(:id).value(:string)

          required(:agent).value(AcaEntities::Brokers::Contracts::AgentContract.params)
          required(:agency).value(AcaEntities::Brokers::Contracts::AgencyContract.params)
          required(:start_on).value(:date)
          optional(:end_on).value(:date)

          required(:person_name).filled(AcaEntities::Contracts::People::PersonNameContract.params)
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
