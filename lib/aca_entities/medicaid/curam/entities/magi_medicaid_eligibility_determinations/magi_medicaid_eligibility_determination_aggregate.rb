require 'digest'

module Ehs
  module MagiMedicaidEligibilityDeterminations
    class MagiMedicaidEligibilityDeterminationAggregate < Sequent::AggregateRoot
      def initialize(command)
        super(command.aggregate_id)
        apply(
          Events::DeterminationIngested,
          {
            aggregate_id: command.aggregate_id,
            checksum: command.checksum,
            payload: command.payload,
            magi_medicaid_eligibility_determination: command.magi_medicaid_eligibility_determination
          }
        )
      end

      def report_duplicate(command)
        apply(
          Events::DuplicateDeterminationReported,
          {
            aggregate_id: command.aggregate_id,
            original_determination_aggregate_id: command.original_determination_aggregate_id
          }
        )
      end

      on Events::DeterminationIngested do |event|
        @payload = event.payload
        @checksum = event.checksum
        @magi_medicaid_eligibility_determination = event.magi_medicaid_eligibility_determination
        @original = true
      end

      on Events::DuplicateDeterminationReported do |event|
        @original = false
        @original_determination_aggregate_id = event.original_determination_aggregate_id
      end
    end
  end
end