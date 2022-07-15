# frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module Contracts
      # Schema and validation rules for {AcaEntities::InsurancePolicies::TaxHousehold}
      class TaxHouseholdContract < Contract
        params do
          optional(:id).maybe(:string)
          required(:tax_household_id).filled(:string)
          required(:assistance_year).filled(:integer, min_size?: 4, gt?: 2013)
          required(:members).array(AcaEntities::InsurancePolicies::Contracts::Members.params)
          required(:health_benchmark_plan_id).value(:string)
          required(:dental_benchmark_plan_id).value(:string)
          required(:aptc_amount).filled(AcaEntities::Types::Money)
          optional(:csr).maybe(:integer, min?: 0, max?: 100)
          optional(:expected_contribution_percentage).maybe(AcaEntities::Types::Money)

          # TODO: verify this is correct location for this value
          optional(:premium_credit_monthly_cap).maybe(AcaEntities::Types::Money)
          required(:begin_on).filled(:date)
          optional(:end_on).maybe(:date)
          optional(:timestamps).filled(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
