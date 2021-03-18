module Ehs
  module IncomeVariances
    class IncomeVarianceCommandHandler < Sequent::CommandHandler
      on RecordIncomeVarianceCommand do |command|
        repository.add_aggregate IncomeVarianceAggregate.new(command)
      end

      on ResolveIncomeVarianceCommand do |command|
        do_with_aggregate(command, IncomeVarianceAggregate) do |aggregate|
          aggregate.resolve(command)
        end
      end

      on ReopenIncomeVarianceCommand do |command|
        do_with_aggregate(command, IncomeVarianceAggregate) do |aggregate|
          aggregate.reopen(command)
        end
      end
    end
  end
end