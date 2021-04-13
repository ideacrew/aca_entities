# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Households
      # Schema and validation rules for {AcaEntities::Households::Household}
      class HouseholdContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Date] :start_date required
        # @option opts [Date] :end_date optional
        # @option opts [Boolean] :is_active optional
        # @option opts [Date] :submitted_at optional
        # @option opts [Hash] :irs_group optional
        # @option opts [Hash] :tax_households optional
        # @option opts [Hash] :coverage_households required
        # @option opts [Hash] :hbx_enrollments optional
        # @return [Dry::Monads::Result]
        params do
          required(:start_date).filled(:date)
          optional(:end_date).maybe(:date)
          required(:is_active).filled(:bool)
          optional(:submitted_at).filled(:date)
          required(:irs_group_reference).hash(AcaEntities::Contracts::Groups::IrsGroupReferenceContract.params)
          required(:tax_households).array(AcaEntities::Contracts::Households::TaxHouseholdContract.params)
          required(:coverage_households).array(AcaEntities::Contracts::Households::CoverageHouseholdContract.params)
          required(:hbx_enrollments).array(AcaEntities::Contracts::Enrollments::HbxEnrollmentContract.params)
        end
      end
    end
  end
end
