# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Households
      # Schema and validation rules for {AcaEntities::Households::CoverageHouseholdMember}
      class CoverageHouseholdMemberContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Hash] :family_member optional
        # @option opts [Boolean] :is_subscriber required
        # @return [Dry::Monads::Result]
        params do
          optional(:family_member).maybe(:hash)
          required(:is_subscriber).maybe(:bool)
        end

        rule(:family_member) do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Families::FamilyMemberReferenceContract.new.call(value)
              key.failure(text: "invalid family member", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid family member. Expected a hash.")
            end
          end
        end
      end
    end
  end
end





