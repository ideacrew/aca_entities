# frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module AcaIndividuals
      module Contracts
        # Schema and validation rules for {AcaEntities::InsurancePolicies::AcaIrsGroup}
        class IrsGroupContract < Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [String] :id
          # @option opts [String] :irs_group_id (required)
          # @option opts [Array<Hash>] :families one or more (in MTHH scenario) Enroll App family (required)
          # @option opts [Array<AcaEntities::InsurancePolicies::AcaIndividuals::Contracts::InsuranceAgreementContract>]
          # :individual_insurance_agreements
          # @option opts [Array<AcaEntities::Contracts::Households::TaxHouseholdGroupContract>] :tax_household_groups
          # Multi-Tax Household attributes
          # @option opts [AcaEntities::Contracts::Households::TaxHouseholdContract] :tax_household Single
          # Tax Household attributes
          # @option opts [Array<Hash>] :edi_db_policies EDI database policy records associated with this IRS Group
          # @option opts [Date] :start_on (required)
          # @option opts [Date] :end_on
          # @option opts [AcaEntities::Contracts::TimeStampContract] :timestamps
          # @return [Dry::Monads::Result::Success, Dry::Monads::Result::Failure] validation result monad
          params do
            optional(:id).maybe(:string)
            required(:irs_group_id).filled(:string)
            required(:insurance_agreements).array(
              AcaEntities::InsurancePolicies::AcaIndividuals::Contracts::InsuranceAgreementContract.params
            )

            # required(:families).array(:hash)
            required(:start_on).filled(:date)
            optional(:end_on).maybe(:date)
            optional(:timestamps).filled(AcaEntities::Contracts::TimeStampContract.params)
          end
        end
      end
    end
  end
end
