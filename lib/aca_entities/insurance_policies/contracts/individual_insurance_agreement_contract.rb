#  frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module Contracts
      # Schema and validation rules for the {AcaEntities::InsurancePolicies::IndividualInsuranceAgreement} entity
      class IndividualInsuranceAgreementContract < Dry::Validation::Contract
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
          required(:insurance_policy).value(AcaEntities::InsurancePolicies::Contracts::InsurancePolicyContract.params)
          required(:begin_on).value(:date)
          required(:end_on).value(:date)
          optional(:effectuated_on).value(:date)
          required(:description).value(:string)
          required(:text).value(:string)
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
