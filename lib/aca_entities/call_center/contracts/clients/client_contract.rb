# frozen_string_literal: true

module AcaEntities
  module CallCenter
    module Contracts
      module Clients

        # Schema and validation rules for the {CallCenter::Operations::Clients::Create} operation
        class ClientContract < Dry::Validation::Contract

          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [String] :access_key_id (required)
          # @option opts [String] :secret_access_key (required)
          # @option opts [Integer] :max_results
          # @return [Dry::Monads::Result::Success] if params pass validation
          # @return [Dry::Monads::Result::Failure] if params fail validation
          params do
            required(:access_key_id).value(:string)
            required(:secret_access_key).value(:string)
          end

        end
      end
    end
  end
end
