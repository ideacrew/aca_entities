# frozen_string_literal: true

require 'uri'

module AcaEntities
  module Accounts
    module Keycloak
      module Contracts
        # Schema and validation rules for {AcaEntities::Accounts::Attributes}
        class AttributesContract < Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [String] :relay_state optional
          # @return [Dry::Monads::Result]
          params do
            # optional(:relay_state).maybe(AcaEntities::Types::EnrollmentExemptionKinds)
            optional(:id).maybe(:string)
            optional(:relay_state).maybe(:string)
            optional(:created_at).maybe(AcaEntities::Types::DateTimeOrNil)
            optional(:updated_at).maybe(AcaEntities::Types::DateTimeOrNil)
          end

          rule(:relay_state) do
            if key? && value
              uri = URI(value)
              path = [uri.path, uri.query].compact.join('?')
              relay_state_kinds = AcaEntities::RelayStateKinds.values

              match_found = true if relay_state_kinds.include?(path)
              # rubocop:disable Style/ZeroLengthPredicate
              match_found = true if relay_state_kinds.any? { |relay_state_kind|
                path.scan(/^#{relay_state_kind}/).size > 0
              }
              # rubocop:enable Style/ZeroLengthPredicate

              key.failure(text: "must be one of: #{AcaEntities::RelayStateKinds.values.join(', ')}") unless match_found
            end
          end
        end
      end
    end
  end
end
