# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Households
      # Schema and validation rules for {AcaEntities::Households::CoverageHousehold}
      class CoverageHouseholdContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Date] :start_date optional
        # @option opts [Date] :end_date optional
        # @option opts [Boolean] :is_immediate_family required
        # @option opts [Boolean] :is_determination_split_household optional
        # @option opts [String] :aasm_state optional
        # @option opts [Date] :submitted_at optional
        # @option opts [Hash] :coverage_household_members required
        # @option opts [Hash] :broker_agency optional
        # @option opts [Hash] :broker_role optional
        # @return [Dry::Monads::Result]
        params do
          optional(:start_date).maybe(:date)
          optional(:end_date).maybe(:date)
          required(:is_immediate_family).filled(:bool)
          optional(:is_determination_split_household).maybe(:bool)
          optional(:aasm_state).maybe(:String)
          optional(:submitted_at).maybe(:Date)
          required(:coverage_household_members).filled(:hash)
          optional(:broker_agency).maybe(:hash)
          optional(:broker_role).maybe(:hash)
        end

        rule(:coverage_household_members).each do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Households::CoverageHouseholdMemberContract.new.call(value)
              key.failure(text: "invalid coverage household member", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid coverage household member. Expected a hash.")
            end
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
      end
    end
  end
end





