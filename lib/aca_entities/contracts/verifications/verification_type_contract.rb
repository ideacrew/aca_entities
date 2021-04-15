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
          optional(:type_name).maybe(:string)
          optional(:validation_status).maybe(:string)
          optional(:applied_roles).maybe(:array)
          optional(:update_reason).maybe(:string)
          optional(:rejected).maybe(:bool)
          optional(:external_service).maybe(:string)
          optional(:due_date).value(:date?)
          optional(:due_date_type).maybe(:string)
          optional(:updated_by).hash(AcaEntities::Contracts::People::PersonReferenceContract.params)
          optional(:inactive).maybe(:bool)
          optional(:vlp_documents).array(AcaEntities::Contracts::Documents::VlpDocumentContract.params)
        end
      end
    end
  end
end
