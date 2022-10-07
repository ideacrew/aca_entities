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
            required(:contract_holder).value(AcaEntities::InsurancePolicies::Contracts::MemberContract.params)
            required(:insurance_provider).value(
              AcaEntities::InsurancePolicies::Contracts::InsuranceProviderContract.params
            )

            # TODO: make this required followin initial 'partial seed' process
            optional(:insurance_policies).array(
              AcaEntities::InsurancePolicies::AcaIndividuals::Contracts::InsurancePolicyContract.params
            )

            # use tax_household in Single THH scenario using date periods to match with enrollments
            optional(:tax_household).array(AcaEntities::Contracts::Households::TaxHouseholdContract.params)

            optional(:plan_year).value(:integer)
            required(:start_on).value(:date)
            optional(:end_on).value(:date)
            optional(:effectuated_on).value(:date)
            optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
          end
        end
      end
    end
  end
end
