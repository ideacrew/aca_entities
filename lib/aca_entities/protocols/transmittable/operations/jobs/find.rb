# frozen_string_literal: true

module AcaEntities
  module Protocols
    module Transmittable
      module Operations
        module Jobs
          # Find a job by id
          class Find
            include Dry::Monads[:result, :do, :try]

            # @param [Hash] opts The options to find a job by id
            # @option opts [Symbol] :id The id of the job to find
            # @return [Dry::Monads::Result::Success] if job is found
            # @return [Dry::Monads::Result::Failure] if job is not found
            def call(opts)
              values = yield validate(opts)
              job = yield find(values)

              Success(job)
            end

            private

            # @param [Hash] opts The options to find a job by id
            # @return [Dry::Monads::Result::Success] if params pass validation
            # @return [Dry::Monads::Result::Failure] if params fail validation
            def validate(opts)
              result = Contracts::FindContract.new.call(opts)
              result.success? ? Success(result) : Failure(result)
            end

            # @param [Hash] values The validated options to find a job by id
            # @return [Dry::Monads::Result::Success] if job is found
            # @return [Dry::Monads::Result::Failure] if job is not found
            def find(values)
              Try do
                job = Job.find(values.to_h[:id])
                job
              end.to_result
            end
          end
        end
      end
    end
  end
end