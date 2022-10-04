#  frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module Contracts
      # Schema and validation rules for the {AcaEntities::InsurancePolicies::IndividualInsuranceAgreement} entity
      class IndividualInsuranceAgreementContract < Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @return [Dry::Monads::Result::Success] if params pass validation
        # @return [Dry::Monads::Result::Failure] if params fail validation
        params do
          optional(:id).value(:string)
          required(:contract_holder).value(AcaEntities::InsurancePolicies::Contracts::MemberContract.params)
          required(:insurance_provider).value(
            AcaEntities::InsurancePolicies::Contracts::InsuranceProviderContract.params
          )
          required(:insurance_policies).array(
            AcaEntities::InsurancePolicies::Contracts::IndividualInsurancePolicyContract.params
          )
          required(:start_on).value(:date)
          optional(:end_on).value(:date)
          optional(:effectuated_on).value(:date)
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
