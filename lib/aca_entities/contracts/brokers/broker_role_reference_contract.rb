# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Brokers
      # Schema and validation rules for {AcaEntities::Brokers::BrokerRoleReference}
      class BrokerRoleReferenceContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :npn required
        # @option opts [Hash] :person required
        # @option opts [Hash] :broker_agency required
        # @return [Dry::Monads::Result]
        params do
          required(:npn).filled(:string)
          required(:person).filled(:hash)
          required(:broker_agency).filled(:hash)
        end

        rule(:person) do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::People::PersonReferenceContract.new.call(value)
              key.failure(text: "invalid person", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid person. Expected a hash.")
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
