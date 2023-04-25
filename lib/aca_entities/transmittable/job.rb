# frozen_string_literal: true

module AcaEntities
  module Transmittable
    # A data model for a single project
    class Job < Dry::Struct
      # @!attribute [r] id
      # A system-assigned unambiguous reference to the resource
      # @return [String]
      attribute :id, Types::Integer.meta(omittable: true)

      # @!attribute [r] job_id
      # An implementation-specific reference to the resource
      # @return [String]
      attribute :job_id, Types::Integer.meta(omittable: false)

      # @!attribute [r] account
      # Identity Management account with this individual's credentials and
      # client system access permissions
      # @return [AcaEntities::Accounts::Account]
      attribute :account, Types::Integer.meta(omittable: true)

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
      # The moment when this job started execution
      # @return [DateTime]
      attribute :started_at, Types::Time.meta(omittable: true)

      # @!attribute [r] ended_at
      # The moment when this job ended execution
      # @return [DateTime]
      attribute :ended_at, Types::Time.meta(omittable: true)

      # @!attribute [r] time_to_live
      # An optional maximum length of time for this job to execute before it expires.  Time value is in seconds.
      # Default value is 0 which never expires
      # @return [String]
      attribute :time_to_live, Types::Integer.meta(omittable: true)

      # @!attribute [r] transmissions
      # The list of one or more transaction collections, grouped by kind, that comprise a single job.
      # @return [Arrya<Transmittable::Transmission>]
      attribute :transmissions, Types::Array.of(Transmittable::Transmission).meta(omittable: true)

      # @!attribute [r] status
      # This current {ProcessState} for this job instance
      # @return [Symbol]
      attribute :status, Types::String.meta(omittable: true)

      # @!attribute [r] process_states
      # The list of ProcessState transitions that occured during execution of this job
      # @return [Array<Transmittable::ProcessState>]
      attribute :process_states, Types::Array.of(Transmittable::ProcessState).meta(omittable: true)

      # @!attribute [r] errors
      # Exceptions that occured during processing of this job
      # @return [Array<Transmittble::Error>]
      attribute :errors, Types::Array.of(Transmittable::Error).meta(omittable: true)

      # @!attribute [r] allow_list
      # The list of {Transmittable::Subject Transmittable::Subjects} transactions to process only. Any transactions for subjects
      # not included in this list are ignored
      # @return [Array<Transmittable::Subject>]
      attribute :allow_list, Types::Array.of(Transmittable::Subject).meta(omittable: true)

      # @!attribute [r] deny_list
      # The list of {Transmittable::Subject Subjects} transactions to exclude from processing. Transactions
      # for all other subjects will process
      # @return [Array<Transmittable::Subject>]
      attribute :deny_list, Types::Array.of(Transmittable::Subject).meta(omittable: true)
    end
  end
end
