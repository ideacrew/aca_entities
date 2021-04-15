# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module MagiMedicaidEligibilityDeterminations
        # MagiMedicaidEligibilityDetermination Projector
        class MagiMedicaidEligibilityDeterminationProjector < Sequent::Projector
          manages_tables MagiMedicaidEligibilityDeterminationRecord, MagiMedicaidEligibilityDeterminationIncomeRecord

          on Events::DeterminationIngested do |event|
            incomes = event.magi_medicaid_eligibility_determination.incomes
            incomes.each do |income|
              create_record(
                MagiMedicaidEligibilityDeterminationIncomeRecord,
                {
                  amount: income.amount,
                  kind: income.kind,
                  frequency: income.frequency,
                  start_date: income.start_date,
                  end_date: income.end_date,
                  aggregate_id: event.aggregate_id
                }
              )
            end
            create_record(
              MagiMedicaidEligibilityDeterminationRecord,
              {
                aggregate_id: event.aggregate_id,
                payload: event.payload,
                checksum: event.checksum,
                person_ids: event.magi_medicaid_eligibility_determination.person_ids
              }
            )
          end

          on Events::DuplicateDeterminationReported do |event|
            update_all_records(
              MagiMedicaidEligibilityDeterminationRecord,
              {
                aggregate_id: event.aggregate_id
              },
              {
                original: false,
                original_determination_aggregate_id: event.original_determination_aggregate_id
              }
            )
          end
        end
      end
    end
  end
end