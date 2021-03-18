# frozen_string_literal: true

module Ehs
  module ParticipantRoles
    module Events
      class RoleCreated < Sequent::Event
        attrs(
          record_status: String,
          version: String,
          role_name: String,
          participation_id: String,
          participation_type: String,
          person_aggregate_id: String,
          last_updated_at: DateTime,
          meta: ::Ehs::ValueObjects::Meta
        )
      end

      class RoleUpdated < Sequent::Event
        attrs(
          record_status: String,
          version: String,
          last_updated_at: DateTime,
          meta: ::Ehs::ValueObjects::Meta
        )
      end
    end
  end
end