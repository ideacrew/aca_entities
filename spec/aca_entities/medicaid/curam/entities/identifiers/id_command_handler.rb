module Ehs
  module Identifiers
    class IdCommandHandler < Sequent::CommandHandler
      on Commands::CreateId do |command|
        repository.add_aggregate IdAggregate.new(command)
      end
    end
  end
end