# frozen_string_literal: true

module AcaEntities
  module Protocols
    module Transmitable
      # A collection of {AcaEntities::Protocols::Transmitable::Transactions} that are transmitted together as a group
      class Transmission < Dry::Struct
        # @!attribute [r] id
        # A system-assigned unambiguous reference to the resource
        # @return [String]
        attribute? :id, Types::String.meta(omittable: true)

        # @!attribute [r] transmission_id
        # An implementation-specific reference to the resource
        # @return [String]
        attribute :transmission_id, Types::String.meta(omittable: false)

        # @!attribute [r] key
        # An unambiguous reference to the resource
        # @return [String]
        attribute :name, Types::String.meta(omittable: true)

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
        attribute :started_at, Types::Time.meta(omittable: true)

        # @!attribute [r] ended_at
        # The moment when this transmission ended execution
        # @return [DateTime]
        attribute :ended_at, Types::Time.meta(omittable: true)

        # @!attribute [r] transmission_transactions
        # The list of one or more transaction collections, grouped by kind, that belong to this transmission
        # @return [Arrya<AcaEntities::Protocols::Transmitable::TransmissionsTransactions>]
        # attribute :transmission_transactions,
        #           Types::Array.of(AcaEntities::Protocols::Transmitable::TransactionsTransmissions).meta(omittable: false)

        # @!attribute [r] status
        # This current {ProcessState} for this transmission instance
        # @return [Symbol]
        attribute :status, Types::String.meta(omittable: true)

        # @!attribute [r] process_states
        # The list of ProcessState transitions that occured during execution of this transmission
        # @return [Array<AcaEntities::Protocols::Transmitable::ProcessState>]
        # attribute :process_states, Types::Array.of(AcaEntities::Protocols::Transmitable::ProcessState).meta(omittable: true)

        # @!attribute [r] errors
        # Exceptions that occured during processing of this transmission
        # @return [Array<Transmittble::Error>]
        # attribute :errors, Types::Array.of(AcaEntities::Protocols::Transmitable::Errors).meta(omittable: true)
      end
    end
  end
end