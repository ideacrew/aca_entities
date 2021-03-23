# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module IncomeVariances
        # IncomeVarianceAggregate
        class IncomeVarianceAggregate < Sequent::AggregateRoot
          def initialize(command)
            super(command.aggregate_id)
            apply(
              Events::IncomeVarianceRecorded,
              {
                aggregate_id: command.aggregate_id,
                application_income_aggregate_id: command.application_income_aggregate_id
              }
            )
          end

          def resolve(command)
            apply(
              Events::IncomeVarianceResolved,
              { aggregate_id: command.aggregate_id }
            )
          end

          def reopen(command)
            apply(
              Events::IncomeVarianceReopened,
              { aggregate_id: command.aggregate_id }
            )
          end

          on Events::IncomeVarianceRecorded do |event|
            @application_income_aggregate_id = event.application_income_aggregate_id
            @status = "unresolved"
          end

          on Events::IncomeVarianceResolved do |_event|
            @status = "resolved"
          end

          on Events::IncomeVarianceReopened do |_event|
            @status = "unresolved"
          end
        end
      end
    end
  end
end