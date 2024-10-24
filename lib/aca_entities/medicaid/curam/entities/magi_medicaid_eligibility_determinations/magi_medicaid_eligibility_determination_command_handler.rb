# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module MagiMedicaidEligibilityDeterminations
        # MagiMedicaidEligibilityDetermination Command Handler
        class MagiMedicaidEligibilityDeterminationCommandHandler < Sequent::CommandHandler
          on IngestMagiMedicaidEligibilityDeterminationCommand do |command|
            repository.add_aggregate MagiMedicaidEligibilityDeterminationAggregate.new(command)
          end

          on ReportDuplicateDeterminationCommand do |command|
            do_with_aggregate(command, MagiMedicaidEligibilityDeterminationAggregate) do |aggregate|
              aggregate.report_duplicate(command)
            end
          end
        end
      end
    end
  end
end