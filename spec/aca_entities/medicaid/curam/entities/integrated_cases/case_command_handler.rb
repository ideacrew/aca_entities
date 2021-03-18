module Ehs
  module IntegratedCases
    class CaseCommandHandler < Sequent::CommandHandler
      on Commands::CreateCase do |command|
        repository.add_aggregate CaseAggregate.new(command)
      end

      on Commands::UpdateCase do |command|
        do_with_aggregate(command, CaseAggregate) do |aggregate|
          aggregate.update(command)
        end
      end
    end
  end
end
