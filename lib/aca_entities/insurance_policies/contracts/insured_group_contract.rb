# frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module Contracts
      # Schema and validation rules for the {AcaEntities::InsurancePolicies::InsuredGroup} entity
      class InsuredGroupContract < Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @return [Dry::Monads::Result::Success] if params pass validation
        # @return [Dry::Monads::Result::Failure] if params fail validation
        params do
          optional(:id).value(:string)
          required(:group_id).value(:string)
          optional(:insurer_assigned_group_id).value(:string)
          required(:organization).value(AcaEntities::Organizations::Organization.params)
          required(:enrollments).array(AcaEntities::InsurancePolicies::Contracts::EnrollmentContract.params)
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
