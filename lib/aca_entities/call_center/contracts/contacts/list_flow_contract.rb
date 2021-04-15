# frozen_string_literal: true

module AcaEntities
  module CallCenter
    module Contracts
      module Contacts

        # Schema and validation rules for the {CallCenter::Operations::Contacts::ListFlow} operation
        class ListFlow < Dry::Validation::Contract

          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [String] :instance_id (required)
          # @option opts [Array<CallCenter::Types::ContactFlow>] :contact_flow_types
          # @return [Dry::Monads::Result::Success] if params pass validation
          # @return [Dry::Monads::Result::Failure] if params fail validation
          params do
            required(:instance_id).filled(:string)
            optional(:contact_flow_types).array(CallCenter::Types::ContactFlow)
            optional(:next_token).value(:string)
            optional(:max_results).value(:integer)
          end

        end
      end
    end
  end
end
