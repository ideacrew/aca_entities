# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Families
      # Schema and validation rules for {AcaEntities::Families::FamilyReference}
      class FamilyReferenceContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :hbx_id required
        # @return [Dry::Monads::Result]
        params do
          required(:hbx_id).value(:str?)
        end
      end
    end
  end
end
