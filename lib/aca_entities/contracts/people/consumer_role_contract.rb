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
        # @option opts [String] :raw_event_responses optional
        # @option opts [String] :bookmark_url optional
        # @option opts [String] :admin_bookmark_url optional
        # @option opts [String] :contact_method optional
        # @option opts [String] :language_preference optional
        # @option opts [Boolean] :is_state_resident optional
        # @option opts [String] :identity_validation optional
        # @option opts [String] :identity_update_reason optional
        # @option opts [String] :application_validation optional
        # @option opts [String] :application_update_reason optional
        # @option opts [String] :identity_rejected optional
        # @option opts [String] :application_rejected optional
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
          optional(:requested_coverage_start_date).maybe(:date)
          optional(:aasm_state).maybe(:string)
          optional(:is_applicant).maybe(:bool)
          optional(:birth_location).maybe(:string)
          optional(:marital_status).maybe(:string)
          optional(:is_active).maybe(:bool)
          optional(:is_applying_coverage).maybe(:bool)
          optional(:raw_event_responses).maybe(:string)
          optional(:bookmark_url).maybe(:string)
          optional(:admin_bookmark_url).maybe(:string)
          optional(:contact_method).maybe(:string)
          optional(:language_preference).maybe(:string)
          optional(:is_state_resident).maybe(:bool)
          optional(:identity_validation).maybe(:string)
          optional(:identity_update_reason).maybe(:string)
          optional(:application_validation).maybe(:string)
          optional(:application_update_reason).maybe(:string)
          optional(:identity_rejected).maybe(:string)
          optional(:application_rejected).maybe(:string)
          optional(:documents).maybe(:array)
          optional(:vlp_documents).maybe(:array)
          optional(:ridp_documents).maybe(:array)
          optional(:verification_type_history_elements).maybe(:array)
          optional(:lawful_presence_determination).maybe(:hash)
          optional(:local_residency_responses).maybe(:array)
          optional(:local_residency_requests).maybe(:array)
        end

        rule(:documents).each do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Documents::DocumentContract.new.call(value)
              key.failure(text: "invalid document.", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid document. Expected a hash.")
            end
          end
        end

        rule(:vlp_documents).each do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Documents::VlpDocumentContract.new.call(value)
              key.failure(text: "invalid vlp_documents.", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid vlp_documents. Expected a hash.")
            end
          end
        end

        rule(:ridp_documents).each do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Documents::RidpDocument.new.call(value)
              key.failure(text: "invalid ridp_documents.", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid ridp_documents. Expected a hash.")
            end
          end
        end

        rule(:verification_type_history_elements).each do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Verifications::VerificationTypeHistoryElementContract.new.call(value)
              key.failure(text: "invalid verification_type_history_elements.", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid verification_type_history_elements. Expected a hash.")
            end
          end
        end

        rule(:lawful_presence_determination) do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Determinations::LawfulPresenceDeterminationContract.new.call(value)
              key.failure(text: "invalid lawful_presence_determination.", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid lawful_presence_determination. Expected a hash.")
            end
          end
        end

        rule(:local_residency_requests).each do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Events::EventRequestContract.new.call(value)
              key.failure(text: "invalid local_residency_requests.", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid local_residency_requests. Expected a hash.")
            end
          end
        end

        rule(:local_residency_responses).each do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Events::EventResponseContract.new.call(value)
              key.failure(text: "invalid local_residency_responses.", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid local_residency_responses. Expected a hash.")
            end
          end
        end
      end
    end
  end
end
