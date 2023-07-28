# frozen_string_literal: true

module AcaEntities
  module Protocols
    module Transmittable
      module Operations
        module ProcessStates
          # Create a new process state
          class Create
            send(:include, Dry::Monads[:result, :do, :try])

            def call(params)
              values = yield validate(params)
              process_state = yield create(values)

              Success(process_state)
            end

            private

            def validate(params)
              result = Contracts::ProcessStateContract.new.call(params)
              result.success? ? Success(result) : Failure(result)
            end

            def create(values)
              Try do
                ProcessState.new(values.to_h)
              end.to_result
            end
          end
        end
      end
    end
  end
end
