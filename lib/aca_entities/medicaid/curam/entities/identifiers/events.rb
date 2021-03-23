# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Identifiers
        module Events
          class IdCreated < Sequent::Event
            attrs(
              key: String,
              item: String,
              start_on: DateTime,
              identifiable_id: String,
              identifiable_type: String
            )
          end
        end
      end
    end
  end
end