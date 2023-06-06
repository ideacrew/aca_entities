# frozen_string_literal: true

module AcaEntities
  module Protocols
    module Transmittable
      module Contracts
        # Schema and validation rules for the {AcaEntities::Protocols::Transmittable::ProcessStatus} entity
        class ProcessStatusContract < Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option params [DateTime] :started_at The moment when this job started execution
          # @option params [DateTime] :ended_at The moment when this job ended execution
          # @option opts [Array<AcaEntities::Protocols::Transmittable::Transaction>]: The list of transactions that belong to this subject
          # @return [Dry::Monads::Result::Success] if params pass validation
          # @return [Dry::Monads::Result::Failure] if params fail validation
          params do
            required(:initial_state_key).value(:symbol)
            required(:status).value(:symbol)
            optional(:elapsed_time).maybe(:integer)
            optional(:process_states).array(AcaEntities::Protocols::Transmittable::Contracts::ProcessStateContract.params)

            optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
          end
        end
      end
    end
  end
end