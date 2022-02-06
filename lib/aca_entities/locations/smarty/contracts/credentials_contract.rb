# frozen_string_literal: true

module AcaEntities
  module Locations
    module Smarty
      module Contracts
        # Schema and validation rules for {AcaEntities::Locations::Smarty::Credentials}
        class CredentialsContract < Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [String] :auth_id required
          # @option opts [String] :auth_token required
          # @return [Dry::Monads::Result]
          params do
            required(:auth_id).maybe(:string)
            required(:auth_token).filled(:string)
          end
        end
      end
    end
  end
end
