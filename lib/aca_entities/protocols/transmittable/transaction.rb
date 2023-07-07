# frozen_string_literal: true

module AcaEntities
  module Protocols
    module Transmittable
      # Within a {AcaEntities::Transmittable::Transmission Transmission} an individual communication event for a
      # Subject Domain Entity
      class Transaction < Dry::Struct
        # @!attribute [r] id
        # A system-assigned unambiguous reference to the resource
        # @return [String]
        attribute? :id, Types::String.optional.meta(omittable: true)

        # @!attribute [r] key
        # An unambiguous reference to the resource kind
        # @return [Symbol]
        attribute :key, Types::Symbol.meta(omittable: false)

        # @!attribute [r] title
        # A name given to the resource by which the resource is formally known
        # @return [String]
        attribute :title, Types::String.optional.meta(omittable: true)

        # @!attribute [r] description
        # An optional account of the content of this resource
        # @return [String]
        attribute :description, Types::String.optional.meta(omittable: true)

        # @!attribute [r] process_status
        # The current state of a process and the history of its state transitions for this transaction
        # @return AcaEntities::Protocols::Transmittable::ProcessStatus
        attribute :process_status, AcaEntities::Protocols::Transmittable::ProcessStatus.meta(omittable: false)

        # @!attribute [r] started_at
        # The moment when this Transaction started execution
        # @return [DateTime]
        attribute :started_at, Types::DateTime.meta(omittable: false)

        # @!attribute [r] ended_at
        # The moment when this Transaction ended execution
        # @return [DateTime]
        attribute :ended_at, Types::DateTime.optional.meta(omittable: true)

        # @!attribute [r] errors
        # The list of exceptions that occurred under this Transaction
        # @return [Array<Transmittble::Error>]
        attribute :errors, Types::Array.of(AcaEntities::Protocols::Transmittable::Errors).meta(omittable: true)

        # @!attribute [r] timestamps
        # Date and time that this resource was originally created and last updated. Time is represented in
        # Coordinated Univeral Time (UTC). System managed.
        # @return [AcaEntities::TimeStamp]
        attribute :timestamps, AcaEntities::TimeStamp.optional.meta(omittable: true)

        # @!attribute [r] json_payload
        # An optional field that stores a json payload being sent as part of the transmission
        # @return [hash]
        attribute :json_payload, Types::Hash.meta(omittable: true)

        # @!attribute [r] xml_payload
        # An optional field that stores a json payload being sent as part of the transmission
        # @return [String]
        attribute :xml_payload, Types::String.meta(omittable: true)
      end
    end
  end
end
