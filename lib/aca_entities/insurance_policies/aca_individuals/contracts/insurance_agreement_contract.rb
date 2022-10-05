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
          # @return [Dry::Monads::Result::Success] if params pass validation
          # @return [Dry::Monads::Result::Failure] if params fail validation
          params do
            optional(:id).value(:string)
            required(:contract_holder).value(AcaEntities::InsurancePolicies::Contracts::MemberContract.params)
            required(:insurance_provider).value(
              AcaEntities::InsurancePolicies::Contracts::InsuranceProviderContract.params
            )
            required(:insurance_policies).array(
              AcaEntities::InsurancePolicies::AcaIndividuals::Contracts::InsurancePolicyContract.params
            )

            optional(:tax_household_groups).array(AcaEntities::Contracts::Households::TaxHouseholdGroupContract.params)
            optional(:tax_household).maybe(AcaEntities::Contracts::Households::TaxHouseholdContract.params)

            required(:start_on).value(:date)
            optional(:end_on).value(:date)
            optional(:effectuated_on).value(:date)
            optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
          end

          # rule(:tax_household_groups, :tax_household) do
          #   if values[:tax_household_groups].blank? && values[:tax_household].blank?
          #     key.failure('tax_household or tax_houshold_group must be present')
          #   end
          # end
        end
      end
    end
  end
end
