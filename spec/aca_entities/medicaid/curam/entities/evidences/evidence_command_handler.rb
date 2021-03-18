# frozen_string_literal: true

module Ehs
  module Evidences
    class EvidenceCommandHandler < Sequent::CommandHandler
      on Commands::CreateIncomeEvidence do |command|
        repository.add_aggregate IncomeEvidenceAggregate.new(command)
      end

      on Commands::UpdateIncomeEvidence do |command|
        do_with_aggregate(command, IncomeEvidenceAggregate) do |aggregate|
          aggregate.update(command)
        end
      end

      on Commands::CreateEvidence do |command|
        repository.add_aggregate EvidenceAggregate.new(command)
      end

      on Commands::UpdateEvidence do |command|
        do_with_aggregate(command, EvidenceAggregate) do |aggregate|
          aggregate.update(command)
        end
      end
    end
  end
end