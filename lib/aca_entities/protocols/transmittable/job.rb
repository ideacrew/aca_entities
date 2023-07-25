# frozen_string_literal: true

module AcaEntities
  module Protocols
    module Transmittable
      # A data model for a single project
      class Job < Dry::Struct
        # @!attribute [r] id
        # A system-assigned unambiguous reference to the resource
        # @return [String]
        attribute :id, Types::Integer.optional.meta(omittable: true)

        # @!attribute [r] job_id
        # A human readable unique identifier
        # @return [String]
        attribute :job_id, Types::String.meta(omittable: false)

        # @!attribute [r] saga_id
        # A system-assigned unique identifier that ties this job to a saga cross services
        # @return [String]
        attribute :saga_id, Types::String.optional.meta(omittable: true)

        # @!attribute [r] account
        # Identity Management account with this individual's credentials and
        # client system access permissions
        # @return [AcaEntities::Accounts::Account]
        attribute :account, Types::Integer.optional.meta(omittable: true)

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

        # @!attribute [r] publish_on
        # The date when this job becomes available for processing
        # @return [DateTime]
        attribute :publish_on, Types::Date.meta(omittable: true)

        # @!attribute [r] expire_on
        # The date when this job is no longer available for processing
        # @return [DateTime]
        attribute :expire_on, Types::DateTime.optional.meta(omittable: true)

        # @!attribute [r] started_at
        # The moment when this job started execution
        # @return [DateTime]
        attribute :started_at, Types::DateTime.meta(omittable: false)

        # @!attribute [r] ended_at
        # The moment when this job ended execution
        # @return [DateTime]
        attribute :ended_at, Types::DateTime.optional.meta(omittable: true)

        # @!attribute [r] time_to_live
        # An optional maximum length of time for this job to execute before it expires.  Time value is in seconds.
        # Default value is 0 which never expires
        # @return [String]
        attribute :time_to_live, Types::Integer.optional.meta(omittable: true)

        # @!attribute [r] transmissions
        # The list of one or more transmissions collections, grouped by kind, that comprise a single job.
        # @return [Arrya<AcaEntities::Protocols::Transmittable::Transmission>]
        attribute :transmissions, Types::Array.of(AcaEntities::Protocols::Transmittable::Transmission).meta(omittable: true)

        # @!attribute [r] process_status
        # The current state of a process and the history of its state transitions
        # @return AcaEntities::Protocols::Transmittable::ProcessStatus
        attribute :process_status, AcaEntities::Protocols::Transmittable::ProcessStatus.meta(omittable: false)

        # @!attribute [r] transmittable_errors
        # The list of exceptions that occurred during processing of this job
        # @return [Array<Transmittble::Error>]
        attribute :transmittable_errors, Types::Array.of(AcaEntities::Protocols::Transmittable::Errors).meta(omittable: false)

        # @!attribute [r] allow_list
        # The list of {AcaEntities::Protocols::Transmittable::Subject AcaEntities::Protocols::Transmittable::Subjects} transactions to process only
        # not included in this list are ignored
        # @return [Array<AcaEntities::Protocols::Transmittable::Subject>]
        attribute :allow_list, Types::Array.of(AcaEntities::Protocols::Transmittable::Subject).meta(omittable: true)

        # @!attribute [r] deny_list
        # The list of {AcaEntities::Protocols::Transmittable::Subject Subjects} transactions to exclude from processing under this job
        # for all other subjects will process
        # @return [Array<AcaEntities::Protocols::Transmittable::Subject>]
        attribute :deny_list, Types::Array.of(AcaEntities::Protocols::Transmittable::Subject).meta(omittable: true)

        # @!attribute [r] timestamps
        # Date and time that this resource was originally created and last updated. Time is represented in
        # Coordinated Univeral Time (UTC). System managed.
        # @return [AcaEntities::TimeStamp]
        attribute :timestamps, AcaEntities::TimeStamp.optional.meta(omittable: true)

        # @!attribute [r] message_id
        # The UUID generated to track transmissions of this job to/from an external service such as CMS
        # @return [String]
        attribute :message_id, Types::String.optional.meta(omittable: true)
      end
    end
  end
end
