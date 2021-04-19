# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Verifications
      # Schema and validation rules for {AcaEntities::Verifications::VerificationTypeHistoryElement}
      class VerificationTypeHistoryElementContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :verification_type optional
        # @option opts [String] :action optional
        # @option opts [String] :modifier optional
        # @option opts [String] :update_reason optional
        # @option opts [Hash] :event_response_record optional
        # @option opts [Hash] :event_request_record optional
        # @return [Dry::Monads::Result]
        params do
          optional(:verification_type).filled(:string)
          optional(:action).filled(:string)
          optional(:modifier).filled(:string)
          optional(:update_reason).filled(:string)
          optional(:event_response_record).hash(AcaEntities::Contracts::Events::EventResponseContract.params)
          optional(:event_request_record).hash(AcaEntities::Contracts::Events::EventRequestContract.params)
        end
      end
    end
  end
end
