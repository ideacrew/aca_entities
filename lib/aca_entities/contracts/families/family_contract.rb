# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Families
      # Schema and validation rules for {AcaEntities::Families::Family}
      class FamilyContract < Dry::Validation::Contract
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
          required(:hbx_id).filled(:string)    #TODO: fix hbx_id in enroll
          optional(:e_case_id).maybe(:string)  #TODO: IdentifierContract
          optional(:e_status_code).maybe(:string)
          optional(:renewal_consent_through_year).filled(:integer)
          optional(:application_type).maybe(:string) #TODO check types
          optional(:is_active).maybe(:bool)
          optional(:submitted_at).maybe(:date)
          optional(:status).maybe(:string)
          optional(:min_verification_due_date).maybe(:date)
          optional(:vlp_documents_status).maybe(:string)
          optional(:applications).maybe(:array)
          optional(:documents).maybe(:array)
          required(:family_members).maybe(:array)
          optional(:special_enrollment_periods).maybe(:array)
          required(:households).filled(:array)
          optional(:broker_accounts).maybe(:array)
          optional(:general_agency_accounts).maybe(:array)
          optional(:irs_groups).maybe(:array)
          optional(:payment_transactions).maybe(:array)
          optional(:updated_by).maybe(:hash)
          optional(:timestamp).maybe(:hash)
        end

        rule(:renewal_consent_through_year) do
          if key? && values[:renewal_consent_through_year]
            key.failure('Not a valid renewal_consent_through_year') unless (2014..2025).cover?(values[:renewal_consent_through_year])
          end
        end

        rule(:applications).each do
          if key? && value
            if value.is_a?(Hash)
              result = MagiMedicaid::Contracts::ApplicationReferenceContract.new.call(value)
              key.failure(text: "invalid application", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid application. Expected a hash.")
            end
          end
        end

        rule(:documents).each do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Documents::DocumentContract.new.call(value)
              key.failure(text: "invalid document", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid documents. Expected a hash.")
            end
          end
        end

        rule(:family_members).each do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Families::FamilyMemberContract.new.call(value)
              key.failure(text: "invalid family member", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid family member. Expected a hash.")
            end
          end
        end

        rule(:special_enrollment_periods).each do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::EnrollmentPeriods::SpecialEnrollmentPeriodContract.new.call(value)
              key.failure(text: "invalid special enrollment period", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid special enrollment period. Expected a hash.")
            end
          end
        end

        rule(:households).each do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Households::HouseholdContract.new.call(value)
              key.failure(text: "invalid household", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid household. Expected a hash.")
            end
          end
        end

        rule(:broker_accounts).each do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Brokers::BrokerAccountContract.new.call(value)
              key.failure(text: "invalid broker account", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid broker account. Expected a hash.")
            end
          end
        end

        rule(:general_agency_accounts).each do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::GeneralAgencies::GeneralAgencyAccountContract.new.call(value)
              key.failure(text: "invalid general agency account", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid general agency account. Expected a hash.")
            end
          end
        end

        rule(:irs_groups).each do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Groups::IrsGroupContract.new.call(value)
              key.failure(text: "invalid irs group", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid irs group. Expected a hash.")
            end
          end
        end

        rule(:payment_transactions).each do
          if key? && value
            if value.is_a?(Hash)
              result = Financial::PaymentTransactions::PaymentTransactionContract.new.call(value)
              key.failure(text: "invalid payment transaction", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid payment transaction. Expected a hash.")
            end
          end
        end

        rule(:updated_by) do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::People::PersonReferenceContract.new.call(value)
              key.failure(text: "invalid updated by", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid updated by. Expected a hash.")
            end
          end
        end

        rule(:timestamp) do
          if key? && value
            if value.is_a?(Hash)
              result = TimeStampContract.new.call(value)
              key.failure(text: "invalid timestamp", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid timestamp. Expected a hash.")
            end
          end
        end
      end
    end
  end
end
