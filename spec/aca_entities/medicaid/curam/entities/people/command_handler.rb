module Ehs
  module People
    class CommandHandler < Sequent::CommandHandler

      on Commands::CreatePerson do |command|
        repository.add_aggregate AggregateRoot.new(command)
      end

      on Commands::UpdatePerson do |command|
        do_with_aggregate(command, AggregateRoot) do |aggregate|
          aggregate.update(command)
        end
      end
    end
  end
end