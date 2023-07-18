# frozen_string_literal: true

module AcaEntities
  module Protocols
    module Transmittable
      module Operations
        module Jobs
          # Create a new job
          class Create
            send(:include, Dry::Monads[:result, :do, :try])

            # @param [Hash] params The options to create a job with
            # @option params [Symbol] :name An unambiguous reference to the resource kind
            # @option params [String] :title A name given to the resource by which the resource is formally known
            # @option params [String] :description A human-readable description
            # @option params [Integer] :time_to_live An optional maximum length of time for this job to execute before it expires.
            # Time value is in seconds
            # @option params [Symbol] :initial_process_state
            # @option params [Date] :publish_on Together with {status} the date when this job is intended to start execution
            def call(params)
              values = yield validate(params)
              job = yield create(values)

              Success(job)
            end

            private

            # @param [Hash] params The options to create a job with
            # @return [Dry::Monads::Result::Success] if params pass validation
            # @return [Dry::Monads::Result::Failure] if params fail validation
            def validate(params)
              result = Contracts::JobContract.new.call(params)
              result.success? ? Success(result) : Failure(result)
            end

            # @param [Hash] values The validated options to create a job with
            # @return [Dry::Monads::Result::Success] if job is created
            # @return [Dry::Monads::Result::Failure] if job is not created
            def create(values)
              Try do
                job = Job.new(values.to_h)
                job
              end.to_result
            end
          end
        end
      end
    end
  end
end
