# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module MagiMedicaidEligibilityDeterminations
        # MagiMedicaidEligibilityDetermination Record
        class MagiMedicaidEligibilityDeterminationRecord < Sequent::ApplicationRecord
          has_many :magi_medicaid_eligibility_determination_income_records, foreign_key: "aggregate_id", primary_key: "aggregate_id"
        end
      end
    end
  end
end