module Ehs
  module People
    module Events
      class PersonCreated < Sequent::Event
        attrs(
          person: PersonValueObject,
          meta: ::Ehs::ValueObjects::Meta
        )
      end

      class PersonUpdated < Sequent::Event
        attrs(
          person: PersonValueObject,
          meta: ::Ehs::ValueObjects::Meta
        )
      end
    end
  end
end