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
          optional(:family_member_reference).hash(AcaEntities::Contracts::Families::FamilyMemberReferenceContract.params)
          required(:is_subscriber).maybe(:bool)
        end
      end
    end
  end
end





