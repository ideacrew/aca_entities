# frozen_string_literal: true

module AcaEntities
  module Accounts
    module Contracts
      # Schema and validation rules for {AcaEntities::Accounts::Attributes}
      class AttributesContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :relay_state optional
        # @return [Dry::Monads::Result]
        params do
        #   optional(:relay_state).maybe(AcaEntities::Types::EnrollmentExemptionKinds)
          optional(:relay_state).maybe(:string)
        end

        rule(:relay_state) do
          if key? && value
            uri = URI(value)
            path = [uri.path, uri.query].compact.join('?')
            key.failure(text: "must be one of: #{AcaEntities::RelayStateKinds.values.join(', ')}") unless AcaEntities::RelayStateKinds.include?(path)
          end
        end
      end
    end
  end
end
