# frozen_string_literal: true

module AcaEntities
  module Protocols
    module Transmittable
      module Contracts
        # Schema and validation rules for the {AcaEntities::Protocols::Transmittable::Transmission} entity
        class ProcessStateContract < Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option params [DateTime] :started_at The moment when this job started execution
          # @option params [DateTime] :ended_at The moment when this job ended execution
          # @option opts [Array<AcaEntities::Protocols::Transmittable::Transaction>]: The list of transactions that belong to this subject
          # @return [Dry::Monads::Result::Success] if params pass validation
          # @return [Dry::Monads::Result::Failure] if params fail validation
          params do
            required(:event).value(:string)
            required(:message).value(:string)
            required(:started_at).value(:date_time)
            optional(:ended_at).maybe(:date_time)
            optional(:seconds_in_state).maybe(:integer)
            optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
            required(:state_key).value(AcaEntities::Protocols::Transmittable::Types::ProcessStateKeyKinds)
          end
        end
      end
    end
  end
end