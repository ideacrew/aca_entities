# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module People
        module Events
          # PersonCreated event
          class PersonCreated < Sequent::Event
            attrs(
              person: PersonValueObject,
              meta: ::Curam::ValueObjects::Meta
            )
          end

          # person Updated event
          class PersonUpdated < Sequent::Event
            attrs(
              person: PersonValueObject,
              meta: ::Curam::ValueObjects::Meta
            )
          end
        end
      end
    end
  end
end