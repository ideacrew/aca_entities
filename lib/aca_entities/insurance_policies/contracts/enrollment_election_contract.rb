# frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module Contracts
      # Schema and validation rules for the {AcaEntities::InsurancePolicies::EnrollmentElection} entity
      class EnrollmentElectionContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @return [Dry::Monads::Result::Success] if params pass validation
        # @return [Dry::Monads::Result::Failure] if params fail validation
        params do
          optional(:id).value(:string)
          required(:enrollment_event).value(AcaEntities::InsurancePolicies::Types::EnrollmentEventKind)
          required(:affected_enrolled_members).array(
            AcaEntities::InsurancePolicies::Contracts::EnrolledMemberContract.params
          )
          required(:effective_date).value(:date)
          optional(:end_on).maybe(AcaEntities::Types::DateOrNil)
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
