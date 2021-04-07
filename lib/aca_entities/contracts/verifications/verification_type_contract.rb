# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Verifications
      # Schema and validation rules for {AcaEntities::Verifications::VerificationType}
      class VerificationTypeContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :type_name optional
        # @option opts [String] :validation_status optional
        # @option opts [Array] :applied_roles optional
        # @option opts [String] :update_reason optional
        # @option opts [Boolean] :rejected optional
        # @option opts [Date] :due_date optional
        # @option opts [String] :due_date_type optional
        # @option opts [Hash] :updated_by optional
        # @option opts [Boolean] :inactive optional
        # @option opts [Array] :vlp_documents optional
        # @return [Dry::Monads::Result]
        params do
          optional(:type_name).filled(:string)
          optional(:validation_status).filled(:string)
          optional(:applied_roles).filled(:array)
          optional(:update_reason).filled(:string)
          optional(:rejected).filled(:bool)
          optional(:external_service).filled(:string)
          optional(:due_date).filled(:date)
          optional(:due_date_type).filled(:string)
          optional(:updated_by).filled(:hash)
          optional(:inactive).filled(:bool)
          optional(:vlp_documents).filled(:array)
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
      end
    end
  end
end
