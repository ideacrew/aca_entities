# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module IncomeVariances
        # IncomeVarianceProjector
        class IncomeVarianceProjector < Sequent::Projector
          manages_tables IncomeVarianceRecord

          on Events::IncomeVarianceRecorded do |event|
            create_record(
              IncomeVarianceRecord,
              {
                aggregate_id: event.aggregate_id,
                application_income_aggregate_id: event.application_income_aggregate_id,
                status: "unresolved"
              }
            )
          end

          on Events::IncomeVarianceResolved do |event|
            update_all_records(
              IncomeVarianceRecord,
              {
                aggregate_id: event.aggregate_id
              },
              {
                status: "resolved"
              }
            )
          end

          on Events::IncomeVarianceReopened do |event|
            update_all_records(
              IncomeVarianceRecord,
              {
                aggregate_id: event.aggregate_id
              },
              {
                status: "unresolved"
              }
            )
          end
        end
      end
    end
  end
end