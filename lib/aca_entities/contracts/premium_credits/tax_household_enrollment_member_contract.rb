# frozen_string_literal: true

module AcaEntities
  module Contracts
    module PremiumCredits
      # Schema and validation rules for {AcaEntities::PremiumCredits::TaxHouseholdEnrollmentMember}
      class TaxHouseholdEnrollmentMemberContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Hash] :hbx_enrollment_member_id required
        # @option opts [Hash] :tax_household_member_id required
        # @option opts [Hash] :member_ehb_benchmark_health_premium optional
        # @option opts [Hash] :member_ehb_benchmark_dental_premium optional
        # @option opts [String] :age_on_effective_date required
        # @return [Dry::Monads::Result]
        params do
          required(:hbx_enrollment_member_id).hash(AcaEntities::Contracts::Enrollments::HbxEnrollmentMemberReferenceContract.params)
          required(:tax_household_member_id).hash(AcaEntities::Contracts::Households::TaxHouseholdMemberReferenceContract.params)
          required(:age_on_effective_date).maybe(:string)
          optional(:member_ehb_benchmark_health_premium).hash(AcaEntities::Contracts::CurrencyContract.params)
          optional(:member_ehb_benchmark_dental_premium).hash(AcaEntities::Contracts::CurrencyContract.params)
        end
      end
    end
  end
end
