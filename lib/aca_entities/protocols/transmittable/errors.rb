# frozen_string_literal: true

module AcaEntities
  module Protocols
    module Transmittable
      module Errors
        # An error raised when an unrecoverable exception occurs during a job processing
        class JobProcessingError < StandardError
          def initialize(job, message)
            super("Critical error Job: #{job}, error: #{message}")
          end
        end

        # An error raised when an unrecoverable exception occurs during a transmission processing
        class TransmissionProcessingError < StandardError
          def initialize(transmission, message)
            super("Critical error Transmission: #{transmission}, error: #{message}")
          end
        end

        # An error raised when an unrecoverable exception occurs during a transaction processing
        class TransactionProcessingError < StandardError
          def initialize(transaction, message)
            super("Critical error Transaction: #{transaction}, error: #{message}")
          end
        end

        # An error raised when an unrecoverable exception occurs during a state transition
        class ProcessStateTransitionError < StandardError
          def initialize(process_state, event)
            super("Critical error Process State: #{process_state} cannot transition to #{event}")
          end
        end
      end
    end
  end
end
