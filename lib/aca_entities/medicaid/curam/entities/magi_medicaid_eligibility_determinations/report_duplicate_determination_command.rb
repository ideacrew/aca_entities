# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module MagiMedicaidEligibilityDeterminations
        # ReportDuplicateDetermination Command
        class ReportDuplicateDeterminationCommand < Sequent::Command
          attrs aggregate_id: String, original_determination_aggregate_id: String

          include Curam::Commands::QuackLikeAnOperation
        end
      end
    end
  end
end