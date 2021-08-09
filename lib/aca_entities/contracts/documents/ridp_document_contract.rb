# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Documents
      # Schema and validation rules for {AcaEntities::Documents::RidpDocument}
      class RidpDocumentContract < Documents::DocumentContract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :status required
        # @option opts [String] :ridp_verification_type optional
        # @option opts [String] :comment optional
        # @option opts [Date] :uploaded_at optional
        # @return [Dry::Monads::Result]
        params do
          required(:status).filled(:string)
          optional(:ridp_verification_type).maybe(:string)
          optional(:comment).maybe(:string)
          optional(:uploaded_at).value(:date)
        end
      end
    end
  end
end