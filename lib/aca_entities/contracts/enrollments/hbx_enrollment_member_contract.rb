# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Enrollments
      # Schema and validation rules for {AcaEntities::Enrollments::HbxEnrollment}
      class HbxEnrollmentMemberContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Hash] :family_member required
        # @option opts [String] :carrier_member_id required
        # @option opts [Boolean] :is_subscriber required
        # @option opts [Hash] :premium_amount required
        # @option opts [Hash] :applied_aptc_amount required
        # @option opts [Date] :eligibility_date required
        # @option opts [Date] :coverage_start_on required
        # @option opts [Date] :coverage_end_on required
        # @option opts [Hash] :slcsp_member_premium optional
        # @return [Dry::Monads::Result]
        params do
          required(:family_member_reference).hash(AcaEntities::Contracts::Families::FamilyMemberReferenceContract.params)
          optional(:carrier_member_id).maybe(:string)
          required(:is_subscriber).filled(:bool)
          optional(:premium_amount).hash(AcaEntities::Contracts::CurrencyContract.params)
          optional(:applied_aptc_amount).hash(AcaEntities::Contracts::CurrencyContract.params)
          required(:eligibility_date).filled(:date)
          required(:coverage_start_on).filled(:date)
          optional(:coverage_end_on).maybe(:date)
          optional(:tobacco_use).maybe(:string)
          optional(:external_id).maybe(:string)
          optional(:slcsp_member_premium).maybe(AcaEntities::Contracts::CurrencyContract.params)
        end
      end
    end
  end
end
