# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module MagiMedicaidEligibilityDeterminations
        module Events
          # Magi medicaid DuplicateDeterminationReported event
          class DuplicateDeterminationReported < Sequent::Event
            attrs(aggregate_id: String, original_determination_aggregate_id: String)
          end
        end
      end
    end
  end
end