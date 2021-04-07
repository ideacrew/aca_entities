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
          optional(:event_response_record).filled(:hash)
          optional(:event_request_record).filled(:hash)
        end

        rule(:event_request_record).each do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Events::EventRequestContract.new.call(value)
              key.failure(text: "invalid event_request_record.", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid event_request_record. Expected a hash.")
            end
          end
        end

        rule(:event_response_record).each do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Events::EventResponseContract.new.call(value)
              key.failure(text: "invalid event_response_record.", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid event_response_record. Expected a hash.")
            end
          end
        end
      end
    end
  end
end
