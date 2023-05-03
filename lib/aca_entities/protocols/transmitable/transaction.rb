# frozen_string_literal: true

module AcaEntities
  module Protocols
    module Transmitable
      # Within a {AcaEntities::Transmitable::Transmission Transmission} an individual communication event for a
      # {AcaEntities::Transmitable::Subject Subject}
      class Transaction < Dry::Struct
        # @!attribute [r] id
        # A system-assigned unambiguous reference to the resource
        # @return [String]
        attribute :id, Types::Integer.meta(omittable: true)

        # @!attribute [r] job_id
        # An implementation-specific reference to the resource
        # @return [String]
        attribute :job_id, Types::Integer.meta(omittable: false)

        # @!attribute [r] name
        # An unambiguous reference to the resource kind
        # @return [Symbol]
        attribute :name, Types::Symbol.meta(omittable: false)

        # @!attribute [r] title
        # A name given to the resource by which the resource is formally known
        # @return [String]
        attribute :title, Types::String.meta(omittable: true)

        # @!attribute [r] description
        # An optional account of the content of this resource
        # @return [String]
        attribute :description, Types::String.meta(omittable: true)

        # @!attribute [r] started_at
        # The moment when this Transaction started execution
        # @return [DateTime]
        attribute :started_at, Types::Time.meta(omittable: true)

        # @!attribute [r] ended_at
        # The moment when this Transaction ended execution
        # @return [DateTime]
        attribute :ended_at, Types::Time.meta(omittable: true)

        # @!attribute [r] status
        # This Transaction's current {AcaEntities::Protocols::Transmitable::ProcessState ProcessState}
        # @return [Symbol]
        attribute :status, Types::Symbol.meta(omittable: true)

        # @!attribute [r] process_states
        # The list of state transitions that occured under this Transaction
        # @return [Array<AcaEntities::Protocols::Transmitable::ProcessState>]
        # attribute :process_states, Types::Array.of(AcaEntities::Protocols::Transmitable::ProcessState).meta(omittable: true)

        # @!attribute [r] errors
        # The list of exceptions that occurred under this Transaction
        # @return [Array<Transmittble::Error>]
        # attribute :errors, Types::Array.of(AcaEntities::Protocols::Transmitable::Errors).meta(omittable: true)

        # @!attribute [r] transactions_transmissions
        # The intersect list of transactions and the transmissions that they belong to
        # @return [Array<AcaEntities::Protocols::Transmitable::TransactionsTransmissions>]
        # attribute :transactions_transmissions, Types::Array
        #   .of(AcaEntities::Protocols::Transmitable::TransactionsTransmissions)
        #   .meta(omittable: true)

        # @!attribute [r] timestamps
        # Date and time that this resource was originally created and last updated. Time is represented in
        # Coordinated Univeral Time (UTC). System managed.
        # @return [AcaEntities::TimeStamp]
        attribute :timestamps, AcaEntities::TimeStamp.meta(omittable: true)
      end
    end
  end
end
