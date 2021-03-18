module Ehs
  module MagiMedicaidEligibilityDeterminations
    class MagiMedicaidEligibilityDeterminationIncomeRecord < Sequent::ApplicationRecord
      belongs_to :magi_medicaid_eligibility_determination_records, foreign_key: "aggregate_id", primary_key: "aggregate_id", required: false
    end
  end
end