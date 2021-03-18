module Ehs
  module Variances
    class CommandHandler < Sequent::CommandHandler
      on Commands::CreateVariance do |command|
        repository.add_aggregate AggregateRoot.new(command)
      end

      on Commands::UpdateVariance do |command|
        do_with_aggregate(command, Ehs::Variances::AggregateRoot) do |aggregate|
          aggregate.update(command)
        end
      end

      on Commands::CloseVariance do |command|
        do_with_aggregate(command, Ehs::Variances::AggregateRoot) do |aggregate|
          aggregate.close(command)
        end
      end
    end
  end
end