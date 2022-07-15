#  frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module Contracts
      # Schema and validation rules for the {AcaEntities::InsurancePolicies::InsuranceProvider} entity
      class InsuranceProviderContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @return [Dry::Monads::Result::Success] if params pass validation
        # @return [Dry::Monads::Result::Failure] if params fail validation
        params do
          optional(:id).value(:string)
          required(:hios_id).filled(:string)
          required(:organization).filled(AcaEntities::Organizations::Contracts::OrganizationContract.params)
          optional(:insurance_policies).array(AcaEntities::InsurancePolicies::Contracts::InsurancePolicyContract.params)
          required(:description).value(:string)
          required(:text).value(:string)
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
