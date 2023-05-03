# frozen_string_literal: true

module AcaEntities
  module Protocols
    module Transmitable
      module Contracts
        # Schema and validation rules for the {AcaEntities::Protocols::Transmitable::Job} entity
        class JobContract < Contract
          # @!method call(params)
          # @param [Hash] params the parameters to validate using this contract
          # @option params [String] :id A unique identifier
          # @option params [String] :job_id An implementation-specific reference to the resource
          # @option params [String] :name An unambiguous reference to the resource kind
          # @option params [String] :title A name given to the resource by which the resource is formally known
          # @option params [String] :description A human-readable description
          # @option params [DateTime] :started_at The moment when this job started execution
          # @option params [DateTime] :ended_at The moment when this job ended execution
          # @option params [Integer] :time_to_live An optional maximum length of time for this job to execute before it expires.
          # Time value is in seconds
          # @option params [Symbol] :status This current ProcessState for this job instance
          # @option params [Array<AcaEntities::Protocols::Transmitable::ProcessState>] :process_states The list of ProcessState transitions that occured
          # during execution of this job
          # @option params [Array<AcaEntities::Protocols::Transmitable::Transmission>] :transmissions The list of transmissions that belong to this job
          # @option params [Array<AcaEntities::Protocols::Transmitable::Errors>] :errors The list of exceptions that occurred during processing of
          # this job
          # @option params [Array<AcaEntities::Protocols::Transmitable::Subject>] :allow_list The list of Subject Transactions to process only under
          # this job
          # @option params [Array<AcaEntities::Protocols::Transmitable::Subject>] :deny_list The list of Subject Transactions to exclude from processing
          # under this job
          # @return [Dry::Monads::Result::Success] if params pass validation
          # @return [Dry::Monads::Result::Failure] if params fail validation
          params do
            optional(:id).maybe(:string)
            optional(:job_id).maybe(:string)
            optional(:account).maybe(AcaEntities::Accounts::Contracts::AccountContract.params)
            required(:name).value(:symbol)
            optional(:title).maybe(:string)
            optional(:description).maybe(:string)
            required(:started_at).value(:date_time)
            optional(:ended_at).maybe(:date_time)
            optional(:time_to_live).maybe(:integer)
            required(:status).value(:symbol)
            required(:process_states).array(AcaEntities::Protocols::Transmitable::Contracts::ProcessStateContract.params)
            optional(:transmissions).array(AcaEntities::Protocols::Transmitable::Contracts::TransmissionContract.params)
            required(:errors).array(AcaEntities::Protocols::Transmitable::Contracts::ErrorsContract.params)
            optional(:allow_list).array(AcaEntities::Protocols::Transmitable::Contracts::SubjectContract.params)
            optional(:deny_list).array(AcaEntities::Protocols::Transmitable::Contracts::SubjectContract.params)

            optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
          end
        end
      end
    end
  end
end
