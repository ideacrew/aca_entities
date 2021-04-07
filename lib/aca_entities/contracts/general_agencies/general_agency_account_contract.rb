# frozen_string_literal: true

module AcaEntities
  module Contracts
    module GeneralAgencies
      # Schema and validation rules for {AcaEntities::GeneralAgencies::GeneralAgencyAccount}
      class GeneralAgencyAccountContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Date] :start_on required
        # @option opts [Date] :end_on optional
        # @option opts [Boolean] :is_active optional
        # @option opts [Boolean] :aasm_state optional
        # @option opts [Hash] :broker_role required
        # @option opts [Hash] :general_agency_profile required
        # @option opts [Hash] :updated_by optional
        # @return [Dry::Monads::Result]
        params do
          required(:start_on).filled(:date)
          optional(:end_on).maybe(:date)
          optional(:is_active).maybe(:bool)
          optional(:aasm_state).maybe(:string)
          required(:broker_role).filled(:hash)
          required(:general_agency).filled(:hash)
          optional(:updated_by).filled(:hash)
        end

        rule(:end_on, :start_on) do
          if values[:end_on]
            key.failure('End on must be after start on date') unless values[:end_on] >= values[:start_on]
          end
        end

        rule(:broker_role) do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Brokers::BrokerRoleContract.new.call(value)
              key.failure(text: "invalid broker role", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid broker role. Expected a hash.")
            end
          end
        end

        rule(:general_agency) do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Organizations::GeneralAgencyReferenceContract.new.call(value)
              key.failure(text: "invalid general agency", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid general agency. Expected a hash.")
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
