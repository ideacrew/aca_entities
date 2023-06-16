# frozen_string_literal: true

module AcaEntities
  module Protocols
    module Transmittable
      module Contracts
        # Schema and validation rules for the {AcaEntities::Protocols::Transmittable::Job} entity
        class JobContract < Contract
          # @!method call(params)
          # @param [Hash] params the parameters to validate using this contract
          # @option params [String] :id A system-assiogned unique identifier
          # @option params [Symbol] :name An unambiguous reference to the resource kind
          # @option params [String] :title A name given to the resource by which the resource is formally known
          # @option params [String] :description A human-readable description
          # @option params [DateTime] :started_at The moment when this job started execution
          # @option params [DateTime] :ended_at The moment when this job ended execution
          # @option params [Integer] :time_to_live An optional maximum length of time for this job to execute before it expires.
          # Time value is in number of seconds
          # @option params [Symbol] :status The current ProcessState for this job instance
          # @option params [Date] :publish_on Together with {status} the date when this job becomes available for processing
          # @option params [Date] :expire_on The date when this job is no longer available for processing
          # @option params [Array<AcaEntities::Protocols::Transmittable::ProcessState>] :process_states The list of ProcessState transitions
          # that occured during execution of this job
          # @option params [Array<AcaEntities::Protocols::Transmittable::Transmission>] :transmissions The list of transmissions that
          # belong to this job
          # @option params [Array<AcaEntities::Protocols::Transmittable::Errors>] :errors The list of exceptions that occurred during processing of
          # this job
          # @option params [Array<AcaEntities::Protocols::Transmittable::Subject>] :allow_list The list of Subject Transactions to process only under
          # this job
          # @option params [Array<AcaEntities::Protocols::Transmittable::Subject>] :deny_list The list of Subject Transactions to exclude from
          # processing under this job
          # @return [Dry::Monads::Result::Success] if params pass validation
          # @return [Dry::Monads::Result::Failure] if params fail validation
          params do
            optional(:id).maybe(:string)
            required(:job_id).value(:string)
            optional(:account).maybe(AcaEntities::Accounts::Contracts::AccountContract.params)
            required(:key).value(:symbol)
            optional(:title).maybe(:string)
            optional(:description).maybe(:string)
            required(:started_at).value(:date_time)
            optional(:ended_at).maybe(:date_time)
            required(:time_to_live).maybe(:integer)
            required(:publish_on).value(:date)
            optional(:expire_on).maybe(:date_time)
            required(:process_status).value(AcaEntities::Protocols::Transmittable::Contracts::ProcessStatusContract.params)
            optional(:transmissions).array(AcaEntities::Protocols::Transmittable::Contracts::TransmissionContract.params)
            required(:errors).array(AcaEntities::Protocols::Transmittable::Contracts::ErrorContract.params)
            optional(:deny_list).array(AcaEntities::Protocols::Transmittable::Contracts::SubjectContract.params)
            optional(:allow_list).array(AcaEntities::Protocols::Transmittable::Contracts::SubjectContract.params)
            optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
          end
        end
      end
    end
  end
end
