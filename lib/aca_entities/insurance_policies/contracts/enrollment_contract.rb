# frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module Contracts
      # Schema and validation rules for the {AcaEntities::InsurancePolicies::Enrollment} entity
      class EnrollmentContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @return [Dry::Monads::Result::Success] if params pass validation
        # @return [Dry::Monads::Result::Failure] if params fail validation
        params do
          optional(:id).value(:string)
          required(:subscriber_service_area_id).value(:string)
          required(:subscriber_rating_area_id).value(:string)
          required(:subscriber).value(AcaEntities::InsurancePolicies::Contracts::EnrolledMemberContract.params)
          optional(:dependents).array(AcaEntities::InsurancePolicies::Contracts::EnrolledMemberContract.params)
          required(:enrollment_elections).array(
            AcaEntities::InsurancePolicies::Contracts::EnrollmentElectionContract.params
          )
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
