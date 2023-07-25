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
              validated_params = yield validate_params(params)
              job_hash = yield create_job_hash(validated_params)
              values = yield validate(job_hash)
              job = yield create(values)

              Success(job)
            end

            private

            def validate_params(params)
              return Failure('Cannot create a job without a key as a symbol') unless params[:key].is_a?(Symbol)
              return Failure('Cannot create a job without a started_at as a DateTime') unless params[:started_at].is_a?(DateTime)
              return Failure('Cannot create a job without a publish_on as a DateTime') unless params[:publish_on].is_a?(DateTime)
      
              Success(params)
            end
      
            def create_job_hash(values)
              Success({
                        job_id: generate_job_id(values[:key]),
                        saga_id: values[:saga_id],
                        key: values[:key],
                        title: values[:title],
                        description: values[:description],
                        publish_on: values[:publish_on],
                        expire_on: values[:expire_on],
                        started_at: values[:started_at],
                        ended_at: values[:ended_at],
                        time_to_live: values[:time_to_live],
                        process_status: create_process_status,
                        errors: [],
                        allow_list: [],
                        deny_list: []
                      })
            end
      
            def create_job_entity(job_hash)
              validation_result = AcaEntities::Protocols::Transmittable::Operations::Jobs::Create.new.call(job_hash)
      
              validation_result.success? ? Success(validation_result.value!) : Failure("Unable to create job due to invalid params")
            end
      
            def generate_job_id(key)
              "#{key}_#{DateTime.now.strftime('%Y%m%d%H%M%S%L')}"
            end
      
            def create_process_status
              AcaEntities::Protocols::Transmittable::Operations::CreateProcessStatus.new.call({ event: 'initial', state_key: :initial, started_at: DateTime.now,
                                                             message: 'created job' }).value!
            end

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
