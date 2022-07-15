# frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module Contracts
      # Schema and validation rules for the {AcaEntities::InsurancePolicies::InsuredGroup} entity
      class InsuredGroupContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @return [Dry::Monads::Result::Success] if params pass validation
        # @return [Dry::Monads::Result::Failure] if params fail validation
        params do
          optional(:id).value(:string)
          required(:hbx_assigned_group_id).value(:string)
          optional(:carrier_assigned_group_id).value(:string)
          required(:enrollments).array(AcaEntities::InsurancePolicies::Contracts::EnrollmentContract.params)
          required(:organization).value(AcaEntities::Organizations::Organization.params)
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
