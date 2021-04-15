# frozen_string_literal: true

module AcaEntities
  module Contracts
    module People
      # Schema and validation rules for {AcaEntities::People::ConsumerRole}
      class ConsumerRoleContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Boolean] :five_year_bar optional
        # @option opts [Date] :requested_coverage_start_date optional
        # @option opts [String] :aasm_state optional
        # @option opts [Boolean] :is_applicant optional
        # @option opts [String] :birth_location optional
        # @option opts [String] :marital_status optional
        # @option opts [Boolean] :is_active optional
        # @option opts [Boolean] :is_applying_coverage optional
        # @option opts [Array] :raw_event_responses optional
        # @option opts [String] :bookmark_url optional
        # @option opts [String] :admin_bookmark_url optional
        # @option opts [String] :contact_method optional
        # @option opts [String] :language_preference optional
        # @option opts [Boolean] :is_state_resident optional
        # @option opts [String] :identity_validation optional
        # @option opts [String] :identity_update_reason optional
        # @option opts [String] :application_validation optional
        # @option opts [String] :application_update_reason optional
        # @option opts [Boolean] :identity_rejected optional
        # @option opts [Boolean] :application_rejected optional
        # @option opts [Array] :documents optional
        # @option opts [Array] :vlp_documents optional
        # @option opts [Array] :ridp_documents optional
        # @option opts [Array] :verification_type_history_elements optional
        # @option opts [Array] :lawful_presence_determination optional
        # @option opts [Array] :local_residency_responses optional
        # @option opts [Array] :local_residency_requests optional
        # @return [Dry::Monads::Result]
        params do
          optional(:five_year_bar).maybe(:bool)
          optional(:requested_coverage_start_date).value(:date?)
          optional(:aasm_state).maybe(:string)
          optional(:is_applicant).filled(:bool)
          optional(:birth_location).maybe(:string)
          optional(:marital_status).maybe(:string)
          optional(:is_active).maybe(:bool)
          required(:is_applying_coverage).filled(:bool)
          optional(:raw_event_responses).maybe(:array)
          optional(:bookmark_url).maybe(:string)
          optional(:admin_bookmark_url).maybe(:string)
          optional(:contact_method).maybe(:string)
          optional(:language_preference).maybe(:string)

          optional(:is_state_resident).maybe(:bool)
          optional(:identity_validation).maybe(:string)
          optional(:identity_update_reason).maybe(:string)
          optional(:application_validation).maybe(:string)
          optional(:application_update_reason).maybe(:string)
          optional(:identity_rejected).maybe(:bool)
          optional(:application_rejected).maybe(:bool)
          # optional(:active_vlp_document_id).maybe(:hash) TODO: revisit
          optional(:documents).array(AcaEntities::Contracts::Documents::DocumentContract.params)
          optional(:vlp_documents).array(AcaEntities::Contracts::Documents::VlpDocumentContract.params)
          optional(:ridp_documents).array(AcaEntities::Contracts::Documents::RidpDocumentContract.params)
          optional(:verification_type_history_elements).array(AcaEntities::Contracts::Verifications::VerificationTypeHistoryElementContract.params)
          optional(:lawful_presence_determination).hash(AcaEntities::Contracts::Determinations::LawfulPresenceDeterminationContract.params)
          optional(:local_residency_responses).array(AcaEntities::Contracts::Events::EventRequestContract.params)
          optional(:local_residency_requests).array(AcaEntities::Contracts::Events::EventResponseContract.params)
        end
      end
    end
  end
end
