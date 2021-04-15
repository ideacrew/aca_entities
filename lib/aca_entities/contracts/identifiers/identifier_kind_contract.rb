# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Identifiers
      # Schema and validation rules for {AcaEntities::Identifiers::Id}
      class IdentifierKindContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :key optional
        # @option opts [String] :label optional
        # @option opts [String] :description optional
        # @option opts [String] :namespace optional
        # @return [Dry::Monads::Result]
        params do
          required(:key).filled(
            AcaEntities::Types::IdentifierKindKey
          )
          required(:label).filled(:string)
          optional(:description).maybe(:string)
          optional(:namespace).maybe(
            AcaEntities::Types::IdentifierKindNamespace
          )
        end
      end
    end
  end
end