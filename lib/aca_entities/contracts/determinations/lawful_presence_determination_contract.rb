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
          optional(:vlp_verified_at).value(:date)
          optional(:vlp_authority).maybe(:string)
          optional(:vlp_document_id).maybe(:string) # TODO: Revisit
          optional(:citizen_status).maybe(:string)
          optional(:citizenship_result).maybe(:string)
          optional(:qualified_non_citizenship_result).maybe(:string)
          optional(:aasm_state).maybe(:string)
          optional(:ssa_responses).array(AcaEntities::Contracts::Events::EventResponseContract.params)
          optional(:ssa_requests).array(AcaEntities::Contracts::Events::EventRequestContract.params)
          optional(:vlp_responses).array(AcaEntities::Contracts::Events::EventResponseContract.params)
          optional(:vlp_requests).array(AcaEntities::Contracts::Events::EventRequestContract.params)
        end
      end
    end
  end
end
