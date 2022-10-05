# frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module AcaIndividuals
      module Contracts
        # Schema and validation rules for {AcaEntities::InsurancePolicies::TaxHousehold}
        class TaxHouseholdGroupContract < Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [String] :id (required)
          # @option opts [String] :tax_household_group_id (required)
          # @option opts [Array<AcaEntities::InsurancePolicies::Contracts::MemberContract>] :members (required)
          # @option opts [Integer] :assistance_year (required)
          # @option opts [AcaEntities::InsurancePolicies::Contracts::InsuranceProductContract] :health_benchmark_plan (required)
          # @option opts [AcaEntities::InsurancePolicies::Contracts::InsuranceProductContract] :dental_benchmark_plan
          # @option opts [AcaEntities::Types::Money] :aptc_amount (required)
          # @option opts [Integer] :csr_percent (required)
          # @option opts [AcaEntities::Types::Money] :expected_contribution_amount (required)
          # @option opts [Date] :start_on (required)
          # @option opts [Date] :end_on
          # @option opts [AcaEntities::Contracts::TimeStampContract] :timestamps
          # @return [Dry::Monads::Result::Success] if params pass validation
          # @return [Dry::Monads::Result::Failure] if params fail validation
          params do
            optional(:id).maybe(:string)
            required(:tax_household_group_id).filled(:string)
            required(:members).array(AcaEntities::InsurancePolicies::Contracts::MemberContract.params)
            required(:assistance_year).filled(:integer, min_size?: 4, gt?: 2013)
            required(:health_benchmark_plan).value(
              AcaEntities::InsurancePolicies::Contracts::InsuranceProductContract.params
            )
            optional(:dental_benchmark_plan).value(
              AcaEntities::InsurancePolicies::Contracts::InsuranceProductContract.params
            )

            # These are premium adjustments
            required(:max_aptc_amount).filled(AcaEntities::Types::Money)
            optional(:csr_percent).maybe(:integer, gteq?: 0, lteq?: 100)
            optional(:expected_contribution_amount).maybe(AcaEntities::Types::Money)

            # TODO: verify this is correct location for this value
            optional(:premium_credit_monthly_cap).maybe(AcaEntities::Types::Money)
            required(:start_on).filled(:date)
            optional(:end_on).maybe(:date)
            optional(:timestamps).filled(AcaEntities::Contracts::TimeStampContract.params)
          end
        end
      end
    end
  end
end
