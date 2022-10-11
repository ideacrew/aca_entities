# frozen_string_literal: true

module AcaEntities
  module Contracts
    module PremiumCredits
      # Schema and validation rules for {AcaEntities::PremiumCredits::TaxHouseholdEnrollment}
      class TaxHouseholdEnrollmentContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Hash] :tax_household_id required
        # @option opts [Hash] :hbx_enrollment_id required
        # @option opts [String] :health_product_hios_id optional
        # @option opts [String] :dental_product_hios_id optional
        # @option opts [Hash] :household_benchmark_ehb_premium required
        # @option opts [Array] :tax_household_enrollment_members required
        # @return [Dry::Monads::Result]
        params do
          required(:tax_household_reference).hash(AcaEntities::Contracts::Households::TaxHouseholdReferenceContract.params)
          required(:hbx_enrollment_reference).hash(AcaEntities::Contracts::Enrollments::HbxEnrollmentReferenceContract.params)
          required(:household_benchmark_ehb_premium).hash(AcaEntities::Contracts::CurrencyContract.params)
          optional(:household_health_benchmark_ehb_premium).maybe(:hash)
          optional(:household_dental_benchmark_ehb_premium).maybe(:hash)
          optional(:health_product_hios_id).maybe(:string)
          optional(:dental_product_hios_id).maybe(:string)
          optional(:applied_aptc).maybe(:hash)
          optional(:available_max_aptc).maybe(:hash)
          required(:tax_household_members_enrollment_members).array(
            AcaEntities::Contracts::PremiumCredits::TaxHouseholdMemberEnrollmentMemberContract.params
          )

        end
      end
    end
  end
end
