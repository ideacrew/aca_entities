# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module CaseDecisions
        # CaseDecisions command handler
        class CommandHandler < Sequent::CommandHandler
          on Commands::CreateCaseDecision do |command|
            repository.add_aggregate ::Curam::CaseDecisions::AggregateRoot.new(command)
          end

          on Commands::UpdateCaseDecision do |command|
            do_with_aggregate(command, ::Curam::CaseDecisions::AggregateRoot) do |aggregate|
              aggregate.update(command)
            end
          end
        end
      end
    end
  end
end