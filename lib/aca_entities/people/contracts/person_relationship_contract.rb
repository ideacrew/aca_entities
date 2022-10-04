# frozen_string_literal: true

module AcaEntities
  module People
    module Contracts
      # Schema and validation rules for {AcaEntities::People::PersonRelationship}
      class PersonRelationshipContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Hash] :relative required
        # @option opts [String] :kind required
        # @return [Dry::Monads::Result]
        params do
          required(:relative).hash(AcaEntities::People::Contracts::PersonReferenceContract.params)
          required(:kind).value(:str?)
        end
      end
    end
  end
end
