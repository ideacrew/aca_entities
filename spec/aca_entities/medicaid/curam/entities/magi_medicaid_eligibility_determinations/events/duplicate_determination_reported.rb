module Ehs
  module MagiMedicaidEligibilityDeterminations
    module Events
      class DuplicateDeterminationReported < Sequent::Event
        attrs(aggregate_id: String, original_determination_aggregate_id: String)
      end
    end
  end
end