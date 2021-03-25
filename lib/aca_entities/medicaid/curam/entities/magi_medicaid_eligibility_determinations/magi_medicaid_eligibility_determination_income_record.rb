# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module MagiMedicaidEligibilityDeterminations
        # MagiMedicaidEligibilityDetermination Income Record
        class MagiMedicaidEligibilityDeterminationIncomeRecord < Sequent::ApplicationRecord
          belongs_to :magi_medicaid_eligibility_determination_records, foreign_key: "aggregate_id", primary_key: "aggregate_id", required: false
        end
      end
    end
  end
end