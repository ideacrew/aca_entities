# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Families
      # Schema and validation rules for {AcaEntities::Families::FamilyMemberReference}
      class FamilyMemberReferenceContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :hbx_id required
        # @return [Dry::Monads::Result]
        params do
          required(:hbx_id).maybe(:string) # TODO: Person hbx_id until we add hbx_id on family member
        end
      end
    end
  end
end
