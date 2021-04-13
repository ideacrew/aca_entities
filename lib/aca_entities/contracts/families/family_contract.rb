# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Families
      # Schema and validation rules for {AcaEntities::Families::Family}
      class FamilyContract < AcaEntities::Contracts::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :hbx_id required
        # @option opts [String] :e_case_id optional
        # @option opts [String] :e_status_code optional
        # @option opts [Integer] :renewal_consent_through_year required
        # @option opts [String] :application_type optional
        # @option opts [Boolean] :is_active optional
        # @option opts [Date] :submitted_at optional
        # @option opts [String] :status optional
        # @option opts [Date] :min_verification_due_date optional
        # @option opts [String] :vlp_documents_status optional
        # @option opts [Array] :applications optional
        # @option opts [Array] :documents optional
        # @option opts [Array] :family_members required
        # @option opts [Array] :special_enrollment_periods optional
        # @option opts [Array] :households required
        # @option opts [Array] :broker_accounts optional
        # @option opts [Array] :general_agency_accounts optional
        # @option opts [Array] :irs_groups optional
        # @option opts [Array] :payment_transactions optional
        # @option opts [Hash] :updated_by optional
        # @option opts [Hash] :timestamp optional
        # @return [Dry::Monads::Result]
        params do
          optional(:hbx_id).filled(:string)
          required(:family_members).array(AcaEntities::Contracts::Families::FamilyMemberContract.params)
          required(:households).array(AcaEntities::Contracts::Households::HouseholdContract.params)
          optional(:e_case_id).maybe(:string)
          optional(:e_status_code).maybe(:string)
          optional(:renewal_consent_through_year).filled(:integer)
          optional(:application_type).maybe(:string)
          optional(:is_active).maybe(:bool)
          optional(:submitted_at).maybe(:date)
          optional(:status).maybe(:string)
          optional(:min_verification_due_date).maybe(:date)
          optional(:vlp_documents_status).maybe(:string)
          optional(:application_references).array(MagiMedicaid::Contracts::ApplicationReferenceContract.params)
          optional(:documents).array(AcaEntities::Contracts::Documents::DocumentContract.params)
          optional(:special_enrollment_periods).array(AcaEntities::Contracts::EnrollmentPeriods::SpecialEnrollmentPeriodContract.params)
          optional(:broker_accounts).array(AcaEntities::Contracts::Brokers::BrokerAccountContract.params)
          optional(:general_agency_accounts).array(AcaEntities::Contracts::GeneralAgencies::GeneralAgencyAccountContract.params)
          optional(:irs_groups).array(AcaEntities::Contracts::Groups::IrsGroupContract.params)
          optional(:payment_transactions).array(Financial::PaymentTransactions::PaymentTransactionContract.params)
          optional(:updated_by).hash(AcaEntities::Contracts::People::PersonReferenceContract.params)
          optional(:timestamp).hash(TimeStampContract.params)
        end
      end
    end
  end
end
