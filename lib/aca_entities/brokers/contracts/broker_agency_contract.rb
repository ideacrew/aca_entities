#  frozen_string_literal: true

module AcaEntities
  module Brokers
    module Contracts
      # Schema and validation rules for the {AcaEntities::InsurancePolicies::InsuranceProvider} entity
      class AgencyContract < Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @return [Dry::Monads::Result::Success] if params pass validation
        # @return [Dry::Monads::Result::Failure] if params fail validation
        params do
          optional(:id).value(:string)
          required(:title).value(:string)
          required(:broker_npn_id).value(:string)
          required(:agents).array(AcaEntities::Brokers::Contracts::AgentAgencyAssignmentContract.params)

          # required(:organization).filled(AcaEntities::Organizations::Contracts::OrganizationContract.params)
          optional(:description).value(:string)
          optional(:text).value(:string)
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
