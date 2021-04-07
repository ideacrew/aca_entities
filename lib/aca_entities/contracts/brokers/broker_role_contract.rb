# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Brokers
      # Schema and validation rules for {AcaEntities::Brokers::BrokerRole}
      class BrokerRoleContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :aasm_state required
        # @option opts [String] :npn required
        # @option opts [String] :provider_kind required
        # @option opts [String] :reason required
        # @option opts [String] :market_kind required
        # @option opts [Array] :languages_spoken required
        # @option opts [Boolean] :working_hours required
        # @option opts [Boolean] :accept_new_clients required
        # @option opts [Boolean] :license required
        # @option opts [Boolean] :training required
        # @option opts [Hash] :carrier_appointments required
        # @option opts [Hash] :broker_agency required
        # @return [Dry::Monads::Result]
        params do
          optional(:aasm_state).maybe(:string)
          required(:npn).filled(:string)
          required(:provider_kind).filled(
            AcaEntities::Types::ProviderKinds
          )
          optional(:reason).maybe(:string)
          optional(:market_kind).maybe(:string)
          optional(:languages_spoken).maybe(:array)
          optional(:working_hours).maybe(:bool)
          optional(:accept_new_clients).maybe(:bool)
          optional(:license).maybe(:bool)
          optional(:training).maybe(:bool)
          optional(:carrier_appointments).maybe(:hash)
          required(:broker_agency).maybe(:hash)
        end

        rule(:broker_agency) do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Organizations::BrokerAgencyProfileReferenceContract.new.call(value)
              key.failure(text: "invalid broker agency", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid broker agency. Expected a hash.")
            end
          end
        end
      end
    end
  end
end

