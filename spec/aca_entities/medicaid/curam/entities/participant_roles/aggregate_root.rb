# frozen_string_literal: true

module Ehs
  module ParticipantRoles
    class AggregateRoot < Sequent::AggregateRoot
      def initialize(command)
        super(command.aggregate_id)
        apply(
          Events::RoleCreated,
          {
            aggregate_id: command.aggregate_id,
            role_name: command.role_name,
            person_aggregate_id: command.person_aggregate_id,
            participation_id: command.participation_id,
            participation_type: command.participation_type,
            version: command.version,
            last_updated_at: command.last_updated_at,
            record_status: command.record_status,
            meta: command.meta
          }
        )
      end

      def update(command)
        if command.last_updated_at > @last_updated_at
          apply(
            Events::RoleUpdated,
            {
              aggregate_id: command.aggregate_id,
              version: command.version,
              last_updated_at: command.last_updated_at,
              record_status: command.record_status,
              meta: command.meta
            }
          )
        end
      end

      on Events::RoleCreated do |event|
        @role_name = event.role_name
        @person_aggregate_id = event.person_aggregate_id
        @participation_id = event.participation_id
        @participation_type = event.participation_type
        @version = event.version
        @last_updated_at = event.last_updated_at
        @record_status = event.record_status
      end

      on Events::RoleUpdated do |event|
        @version = event.version
        @last_updated_at = event.last_updated_at
        @record_status = event.record_status
      end
    end
  end
end