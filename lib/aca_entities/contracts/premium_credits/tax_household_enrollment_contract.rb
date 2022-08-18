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
        # @option opts [Hash] :total_benchmark_ehb_premium required
        # @option opts [Array] :tax_household_enrollment_members required
        # @return [Dry::Monads::Result]
        params do
          required(:tax_household_id).hash(AcaEntities::Contracts::Households::TaxHouseholdReferenceContract.params)
          required(:hbx_enrollment_id).hash(AcaEntities::Contracts::Enrollments::HbxEnrollmentReferenceContract.params)
          required(:total_benchmark_ehb_premium).hash(AcaEntities::Contracts::CurrencyContract.params)
          optional(:health_product_hios_id).maybe(:string)
          optional(:dental_product_hios_id).maybe(:string)
          required(:tax_household_enrollment_members).array(AcaEntities::Contracts::PremiumCredits::TaxHouseholdEnrollmentMemberContract.params)
        end
      end
    end
  end
end
