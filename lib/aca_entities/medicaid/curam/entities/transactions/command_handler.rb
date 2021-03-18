module Ehs
  module Transactions
    class CommandHandler < Sequent::CommandHandler
      on Commands::CreateTransaction do |command|
        repository.add_aggregate AggregateRoot.new(command)
      end

      on Commands::UpdateTransaction do |command|
        do_with_aggregate(command, Ehs::Transactions::AggregateRoot) do |aggregate|
          aggregate.update(command)
        end
      end
    end
  end
end