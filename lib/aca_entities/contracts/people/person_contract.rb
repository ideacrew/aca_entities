# frozen_string_literal: true

require 'aca_entities/contracts/applicant_role_contract'

module AcaEntities
  module Contracts
    module People
      # Schema and validation rules for {AcaEntities::People::Person}.
      class PersonContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :hbx_id required
        # @option opts [Hash] :person_name required
        # @option opts [Hash] :person_demographics required
        # @option opts [Hash] :person_health required
        # @option opts [Boolean] :is_active required
        # @option opts [Boolean] :is_disabled required
        # @option opts [Boolean] :no_dc_address optional
        # @option opts [Boolean] :no_dc_address_reason optional
        # @option opts [Boolean] :is_homeless optional
        # @option opts [Boolean] :is_temporarily_out_of_state optional
        # @option opts [Boolean] :age_off_excluded optional
        # @option opts [Boolean] :is_applying_for_assistance optional
        # @option opts [Array] :person_relationships optional
        # @option opts [Hash] :consumer_role optional
        # @option opts [Hash] :resident_role optional
        # @option opts [Array] :individual_market_transitions optional
        # @option opts [Array] :verification_types optional
        # @option opts [Hash] :broker_role optional
        # @option opts [Array] :broker_agency_staff_roles optional
        # @option opts [Array] :general_agency_staff_roles optional
        # @option opts [Array] :employee_roles optional
        # @option opts [Array] :employer_staff_roles optional
        # @option opts [Array] :addresses optional
        # @option opts [Array] :phones optional
        # @option opts [Array] :emails optional
        # @option opts [Array] :documents optional
        # @option opts [Hash] :timestamp optional
        # @return [Dry::Monads::Result]
        params do
          required(:hbx_id).maybe(:string)
          required(:person_name).maybe(:hash)
          required(:person_demographics).maybe(:hash)
          required(:person_health).maybe(:hash)
          required(:is_active).maybe(:string)
          required(:is_disabled).maybe(:bool)

          optional(:no_dc_address).filled(:bool)
          optional(:no_dc_address_reason).filled(:bool)
          optional(:is_homeless).maybe(:bool)
          optional(:is_temporarily_out_of_state).maybe(:bool)
          optional(:age_off_excluded).maybe(:bool)
          optional(:is_applying_for_assistance).maybe(:bool)
          optional(:person_relationships).maybe(:array)
          optional(:consumer_role).maybe(:hash)
          optional(:resident_role).maybe(:hash)
          optional(:individual_market_transitions).maybe(:array)
          optional(:verification_types).maybe(:array)
          optional(:broker_role).maybe(:hash)
          optional(:broker_agency_staff_roles).maybe(:array)
          optional(:general_agency_staff_roles).maybe(:array)
          optional(:employee_roles).maybe(:array)
          optional(:employer_staff_roles).maybe(:array)
          optional(:addresses).maybe(:array)
          optional(:phones).maybe(:array)
          optional(:emails).maybe(:array)
          optional(:documents).maybe(:array)
          optional(:timestamp).maybe(:hash)
        end

        rule(:person_name) do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::People::PersonName.new.call(value)
              key.failure(text: "invalid person_name", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid person_name. Expected a hash.")
            end
          end
        end

        rule(:person_demographics) do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::People::PersonDemographicsContract.new.call(value)
              key.failure(text: "invalid person_demographics", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid person_demographics. Expected a hash.")
            end
          end
        end

        rule(:person_health) do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::People::PersonHealth.new.call(value)
              key.failure(text: "invalid person_health", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid person_health. Expected a hash.")
            end
          end
        end

        rule(:person_relationships).each do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::People::PersonRelationshipContract.new.call(value)
              key.failure(text: "invalid person_relationships", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid person_relationships. Expected a hash.")
            end
          end
        end

        rule(:consumer_role) do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::People::ConsumerRoleContract.new.call(value)
              key.failure(text: "invalid consumer_role", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid consumer_role. Expected a hash.")
            end
          end
        end

        rule(:resident_role) do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::People::ResidentRoleContract.new.call(value)
              key.failure(text: "invalid resident_role", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid resident_role. Expected a hash.")
            end
          end
        end

        rule(:individual_market_transitions).each do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Determinations::IndividualMarketTransitionContract.new.call(value)
              key.failure(text: "invalid individual_market_transitions", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid individual_market_transitions. Expected a hash.")
            end
          end
        end

        rule(:verification_types).each do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Verifications::VerificationTypeContract.new.call(value)
              key.failure(text: "invalid verification_types", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid verification_types. Expected a hash.")
            end
          end
        end

        rule(:broker_role) do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Brokers::BrokerRoleContract.new.call(value)
              key.failure(text: "invalid verification_types", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid verification_types. Expected a hash.")
            end
          end
        end

        rule(:phones).each do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Contact::PhoneContract.new.call(value)
              key.failure(text: "invalid phone", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid phones. Expected a hash.")
            end
          end
        end

        rule(:emails).each do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Contact::EmailContract.new.call(value)
              key.failure(text: "invalid email", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid emails. Expected a hash.")
            end
          end
        end

        rule(:addresses).each do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Locations::AddressContract.new.call(value)
              key.failure(text: "invalid addresses", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid addresses. Expected a hash.")
            end
          end
        end

        rule(:documents).each do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Documents::DocumentContract.new.call(value)
              key.failure(text: "invalid documents", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid documents. Expected a hash.")
            end
          end
        end

        rule(:timestamp) do
          if key? && value
            if value.is_a?(Hash)
              result = TimeStampContract.new.call(value)
              key.failure(text: "invalid timestamp", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid timestamp. Expected a hash.")
            end
          end
        end
      end
    end
  end
end
