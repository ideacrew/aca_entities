#  frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module AcaIndividuals
      module Contracts
        # An agreement between a Contract Holder and a Provider of Insurance Product(s)
        # Schema and validation rules for the {AcaEntities::InsurancePolicies::IndividualInsuranceAgreement} entity
        class InsuranceAgreementContract < Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [Integer] :contract_holder the party responsible for the policies and payment

          # @return [Dry::Monads::Result::Success] if params pass validation
          # @return [Dry::Monads::Result::Failure] if params fail validation
          params do
            optional(:id).value(:string)
            required(:plan_year).value(:integer)
            required(:contract_holder).value(AcaEntities::InsurancePolicies::Contracts::MemberContract.params)
            required(:insurance_provider).value(
              AcaEntities::InsurancePolicies::Contracts::InsuranceProviderContract.params
            )
            optional(:insurance_policies).array(
              AcaEntities::InsurancePolicies::AcaIndividuals::Contracts::InsurancePolicyContract.params
            )
            optional(:start_on).value(:date)
            optional(:end_on).value(:date)
            optional(:effectuated_on).value(:date)
            optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
          end
        end
      end
    end
  end
end