module Ehs
  module MagiMedicaidEligibilityDeterminations
    class ReportDuplicateDeterminationCommand < Sequent::Command
      attrs aggregate_id: String, original_determination_aggregate_id: String

      include Ehs::Commands::QuackLikeAnOperation
    end
  end
end