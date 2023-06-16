# frozen_string_literal: true

module AcaEntities
  module Protocols
    module Transmittable
      # A collection of {AcaEntities::Protocols::Transmittable::Transactions} that are transmitted together as a group
      class Transmission < Dry::Struct
        # @!attribute [r] id
        # A system-assigned unambiguous reference to the resource
        # @return [String]
        attribute? :id, Types::String.meta(omittable: true)

        # @!attribute [r] key
        # An unambiguous reference to the resource
        # @return [String]
        attribute :key, Types::Symbol.meta(omittable: false)

        # @!attribute [r] title
        # A name given to the resource by which the resource is formally known
        # @return [String]
        attribute :title, Types::String.meta(omittable: true)

        # @!attribute [r] description
        # An optional account of the content of this resource
        # @return [String]
        attribute :description, Types::String.meta(omittable: true)

        # @!attribute [r] started_at
        # The moment when this transmission started execution
        # @return [DateTime]
        attribute :started_at, Types::Time.meta(omittable: false)

        # @!attribute [r] ended_at
        # The moment when this transmission ended execution
        # @return [DateTime]
        attribute :ended_at, Types::Time.meta(omittable: true)

        # @!attribute [r] transmission_transactions
        # The list of one or more transaction collections, grouped by kind, that belong to this transmission
        # @return [Arrya<AcaEntities::Protocols::Transmittable::TransmissionsTransactions>]
        attribute :transactions_transmissions, Types::Array
          .of(AcaEntities::Protocols::Transmittable::TransactionsTransmissions)
          .meta(omittable: false)

        # @!attribute [r] process_status
        # The current state of a process and the history of its state transitions for this transmission
        # @return AcaEntities::Protocols::Transmittable::ProcessStatus
        attribute :process_status, AcaEntities::Protocols::Transmittable::ProcessStatus.meta(omittable: false)

        # @!attribute [r] errors
        # Exceptions that occured during processing of this transmission
        # @return [Array<Transmittble::Error>]
        attribute :errors, Types::Array.of(AcaEntities::Protocols::Transmittable::Errors).meta(omittable: true)
      end
    end
  end
end