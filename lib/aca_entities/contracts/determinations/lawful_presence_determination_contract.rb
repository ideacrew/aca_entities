# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Determinations
      # # Schema and validation rules for {AcaEntities::Determinations::LawfulPresenceDetermination}
      class LawfulPresenceDeterminationContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :vlp_verified_at required
        # @option opts [String] :vlp_authority optional
        # @option opts [String] :vlp_document_id required
        # @option opts [String] :citizen_status required
        # @option opts [String] :citizenship_result optional
        # @option opts [String] :qualified_non_citizenship_result optional
        # @option opts [String] :aasm_state optional
        # @option opts [Array] :ssa_responses optional
        # @option opts [Array] :ssa_requests optional
        # @option opts [Array] :vlp_responses optional
        # @option opts [Array] :vlp_requests optional
        # @return [Dry::Monads::Result]
        params do
          optional(:vlp_verified_at).maybe(:date)
          optional(:vlp_authority).maybe(:string)
          optional(:vlp_document_id).maybe(:string) # TODO: check this
          optional(:citizen_status).maybe(:string)
          optional(:citizenship_result).maybe(:string)
          optional(:qualified_non_citizenship_result).maybe(:string)
          optional(:aasm_state).maybe(:string)
          optional(:ssa_responses).maybe(:array)
          optional(:ssa_requests).maybe(:array)
          optional(:vlp_responses).maybe(:array)
          optional(:vlp_requests).maybe(:array)
        end

        rule(:ssa_responses).each do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Events::EventResponse.new.call(value)
              key.failure(text: "invalid ssa response", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid ssa response. Expected a hash.")
            end
          end
        end

        rule(:ssa_requests).each do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Events::EventRequest.new.call(value)
              key.failure(text: "invalid ssa request", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid ssa request. Expected a hash.")
            end
          end
        end

        rule(:vlp_responses).each do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Events::EventResponse.new.call(value)
              key.failure(text: "invalid ssa response", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid ssa response. Expected a hash.")
            end
          end
        end

        rule(:vlp_requests).each do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Events::EventRequest.new.call(value)
              key.failure(text: "invalid ssa request", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid ssa request. Expected a hash.")
            end
          end
        end
      end
    end
  end
end
