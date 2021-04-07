# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Households
      # Schema and validation rules for {AcaEntities::Households::TaxHouseholdMembe}
      class TaxHouseholdMemberContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Hash] :family_member required
        # @option opts [Hash] :product_eligibility_determination optional
        # @option opts [Boolean] :is_subscriber optional
        # @option opts [Date] :reason optional
        # @return [Dry::Monads::Result]
        params do
          optional(:family_member).maybe(:hash)
          optional(:product_eligibility_determination).maybe(:hash)
          optional(:is_subscriber).maybe(:bool)
          optional(:reason).maybe(:string)
        end

        rule(:family_member) do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Families::FamilyMemberReferenceContract.new.call(value)
              key.failure(text: "invalid family", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid family. Expected a hash.")
            end
          end
        end

        rule(:product_eligibility_determination) do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Determinations::ProductEligibilityDeterminationContract.new.call(value)
              key.failure(text: "invalid product eligibility determination", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid product eligibility determination. Expected a hash.")
            end
          end
        end
      end
    end
  end
end
