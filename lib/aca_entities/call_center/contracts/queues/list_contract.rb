# frozen_string_literal: true

module AcaEntities
  module CallCenter
    module Contracts
      module Queues

        # Schema and validation rules for the {CallCenter::Operations::Queues::List} operation
        class ListContract < Dry::Validation::Contract

          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [String] :instance_id (required)
          # @option opts [Array<CallCenter::Types::Queue>] :queue_types
          # @option opts [String] :next_token
          # @option opts [Integer] :max_results
          # @return [Dry::Monads::Result::Success] if params pass validation
          # @return [Dry::Monads::Result::Failure] if params fail validation
          params do
            required(:instance_id).value(:string)
            optional(:queue_types).array(CallCenter::Types::Queue)
            optional(:next_token).value(:string)
            optional(:max_results).value(:integer)
          end

        end
      end
    end
  end
end
