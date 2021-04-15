# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Identifiers
        # Id Aggregate
        class IdAggregate < Sequent::AggregateRoot
          def initialize(command)
            super(command.aggregate_id)
            apply(
              Events::IdCreated,
              {
                aggregate_id: command.aggregate_id,
                identifiable_id: command.identifiable_id,
                identifiable_type: command.identifiable_type,
                key: command.key,
                item: command.item,
                start_on: command.start_on
              }
            )
          end

          on Events::IdCreated do |event|
            @start_on = event.start_on
            @identifiable_type = event.identifiable_type
            @identifiable_id = event.identifiable_id
            @key = event.key
            @item = event.item
          end
        end
      end
    end
  end
end
