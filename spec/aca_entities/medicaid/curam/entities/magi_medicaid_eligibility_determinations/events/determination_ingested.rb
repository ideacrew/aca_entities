module Ehs
  module MagiMedicaidEligibilityDeterminations
    module Events
      class DeterminationIngested < Sequent::Event
        attrs(
          aggregate_id: String,
          payload: String,
          checksum: String,
          magi_medicaid_eligibility_determination: MagiMedicaidEligibilityDeterminationValueObject
        )
      end
    end
  end
end