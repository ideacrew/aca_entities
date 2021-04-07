# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Brokers
      # Schema and validation rules for {AcaEntities::Brokers::BrokerAccount}
      class BrokerAccountContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Date] :start_on required
        # @option opts [Date] :end_on optional
        # @option opts [Boolean] :is_active required
        # @option opts [Hash] :broker_role required
        # @option opts [Hash] :broker_agency required
        # @option opts [Hash] :updated_by optional
        # @return [Dry::Monads::Result]
        params do
          required(:start_on).filled(:date)
          optional(:end_on).maybe(:date)
          required(:is_active).maybe(:bool)
          required(:broker_role).filled(:hash)
          required(:broker_agency).filled(:hash)
          optional(:updated_by).filled(:hash)
        end

        rule(:end_on, :start_on) do
          if values[:end_on]
            key.failure('end on must be after start on') if values[:end_on] < values[:start_on]
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


