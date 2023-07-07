# frozen_string_literal: true

module AcaEntities
  module Protocols
    module Transmittable
      module Contracts
        # Schema and validation rules for the {AcaEntities::Protocols::Transmittable::JobRegistry} entity
        class JobRegistryContract < Contract
          # @!method call(params)
          # @param [Hash] params the parameters to validate using this contract
          # @option params [Symbol] :name An unambiguous reference to the resource kind
          # @option params [String] :title A name given to the resource by which the resource is formally known
          # @option params [String] :description A human-readable description for this resource
          # @option params [Array<AcaEntities::Protocols::Transmittable::Contracts::Job.params>] :jobs The list of
          # registered {AcaEntities::Protocols::Transmittable::Job} objects
          # @return [Dry::Monads::Result::Success] if params pass validation
          # @return [Dry::Monads::Result::Failure] if params fail validation
          required(:name).value(:symbol)
          required(:title).maybe(:string)
          optional(:description).maybe(:string)
          optional(:jobs).array(AcaEntities::Protocols::Transmittable::Contracts::JobContract.params)
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end