# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Households
      # Schema and validation rules for {AcaEntities::Households::HouseholdReference}
      class HouseholdReferenceContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @return [Dry::Monads::Result]
        # rubocop:disable Lint/EmptyBlock
        params do

        end
        # rubocop:enable Lint/EmptyBlock
      end
    end
  end
end