module Ehs
  module People
    class AggregateRoot < Sequent::AggregateRoot
      def initialize(command)
        super(command.aggregate_id)
        apply(
          Events::PersonCreated,
          {
            aggregate_id: command.aggregate_id,
            person: command.person,
          }
        )
      end

      def update(command)
        apply Events::PersonUpdated, person: command.person
      end

      on Events::PersonCreated do |event|
        @person = event.person
      end

      on Events::PersonUpdated do |event|
        @person = event.person
      end
    end
  end
end
