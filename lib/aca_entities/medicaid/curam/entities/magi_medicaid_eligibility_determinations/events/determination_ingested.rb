# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module MagiMedicaidEligibilityDeterminations
        module Events
          # Magi medicaid DeterminationIngested event
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
  end
end