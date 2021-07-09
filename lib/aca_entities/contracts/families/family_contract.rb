# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Families
      # Schema and validation rules for {AcaEntities::Families::Family}
      class FamilyContract < AcaEntities::Contracts::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :hbx_id required
        # @option opts [Array] :foreign_keys optional
        # @option opts [Integer] :renewal_consent_through_year required
        # @option opts [String] :application_type optional
        # @option opts [Date] :min_verification_due_date optional
        # @option opts [String] :vlp_documents_status optional
        # @option opts [Array] :application_references optional
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
        # @option opts [Boolean] :documents_needed optional
        # @return [Dry::Monads::Result]
        params do
          required(:family_members).array(AcaEntities::Contracts::Families::FamilyMemberContract.params)
          optional(:households).maybe(:array).each(AcaEntities::Contracts::Households::HouseholdContract.params)

          optional(:hbx_id).filled(:string)
          optional(:foreign_keys).array(AcaEntities::Contracts::Identifiers::IdContract.params)
          optional(:renewal_consent_through_year).filled(:integer, included_in?: 2014..2025)
          # TODO: Fix this, Move to right namespace as per DAN
          # optional(:application_type).maybe(:string)
          # TODO: Move to appropriate model
          optional(:min_verification_due_date).maybe(:date)
          optional(:vlp_documents_status).maybe(:string)
          optional(:magi_medicaid_applications).array(MagiMedicaid::Contracts::ApplicationContract.params)
          optional(:documents).array(AcaEntities::Contracts::Documents::DocumentContract.params)
          optional(:special_enrollment_periods).array(AcaEntities::Contracts::EnrollmentPeriods::SpecialEnrollmentPeriodContract.params)
          optional(:broker_accounts).array(AcaEntities::Contracts::Brokers::BrokerAccountContract.params)
          optional(:general_agency_accounts).array(AcaEntities::Contracts::GeneralAgencies::GeneralAgencyAccountContract.params)
          optional(:irs_groups).array(AcaEntities::Contracts::Groups::IrsGroupContract.params)
          optional(:payment_transactions).array(Financial::PaymentTransactions::PaymentTransactionContract.params)
          optional(:updated_by).hash(AcaEntities::Contracts::People::PersonReferenceContract.params)
          optional(:timestamp).hash(TimeStampContract.params)
          optional(:documents_needed).maybe(:bool)
        end

        # Need to have below rule and cannot move all MagiMedicaidApplication level rules to AcaEntities::Contracts::Contract because
        # we will be calling AcaEntities::MagiMedicaid::Contracts::ApplicationContract separately during determination requests to MitC
        # and we do not want the params to be validated without the rules.
        rule(:magi_medicaid_applications).each do |index:|
          if key? && value
            if value.is_a?(Hash)
              result = MagiMedicaid::Contracts::ApplicationContract.new.call(value)
              key([:applications, index]).failure(text: 'invalid magi_medicaid application', error: result.errors.to_h) if result&.failure?
            else
              key([:applications, index]).failure(text: 'invalid magi_medicaid applications. Expected a hash.')
            end
          end
        end
      end
    end
  end
end
