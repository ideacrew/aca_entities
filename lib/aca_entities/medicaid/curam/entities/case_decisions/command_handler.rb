# frozen_string_literal: true

module Ehs
  module CaseDecisions
    class CommandHandler < Sequent::CommandHandler
      on Commands::CreateCaseDecision do |command|
        repository.add_aggregate ::Ehs::CaseDecisions::AggregateRoot.new(command)
      end

      on Commands::UpdateCaseDecision do |command|
        do_with_aggregate(command, ::Ehs::CaseDecisions::AggregateRoot) do |aggregate|
          aggregate.update(command)
        end
      end
    end
  end
end