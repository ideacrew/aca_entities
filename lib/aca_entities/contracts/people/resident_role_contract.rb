# frozen_string_literal: true

module AcaEntities
  module Contracts
    module People
      # Schema and validation rules for {AcaEntities::People::ResidentRole}
      class ResidentRoleContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Hash] :is_applicant required
        # @option opts [String] :is_active optional
        # @option opts [String] :is_state_resident required
        # @option opts [String] :residency_determined_at optional
        # @option opts [String] :contact_method optional
        # @option opts [String] :language_preference optional
        # @option opts [String] :local_residency_responses optional
        # @option opts [String] :lawful_presence_determination optional
        # @return [Dry::Monads::Result]
        params do
          required(:is_applicant).filled(:bool)
          optional(:is_active).maybe(:bool)
          required(:is_state_resident).filled(:bool)
          optional(:residency_determined_at).maybe(:date)
          optional(:contact_method).maybe(:string)
          optional(:language_preference).maybe(:string)
          optional(:local_residency_responses).maybe(:array)
          optional(:lawful_presence_determination).maybe(:hash)
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

      end
    end
  end
end
