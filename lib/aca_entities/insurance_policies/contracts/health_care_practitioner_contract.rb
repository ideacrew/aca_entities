# frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module Contracts
      # Schema and validation rules for the {AcaEntities::InsurancePolicies::HealthCarePractitioner} entity
      class HealthCarePractitionerContract < Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @return [Dry::Monads::Result::Success] if params pass validation
        # @return [Dry::Monads::Result::Failure] if params fail validation
        params do
          optional(:id).value(:string)
          required(:name).value(AcaEntities::Contracts::People::PersonNameContract.params)

          # optional(:organization).value(AcaEntities::Organizations::Contracts::OrganizationContract.params)
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
