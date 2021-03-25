# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module ParticipantRoles
        module Events
          # create role event
          class RoleCreated < Sequent::Event
            attrs(
              record_status: String,
              version: String,
              role_name: String,
              participation_id: String,
              participation_type: String,
              person_aggregate_id: String,
              last_updated_at: DateTime,
              meta: ::Curam::ValueObjects::Meta
            )
          end

          class RoleUpdated < Sequent::Event
            attrs(
              record_status: String,
              version: String,
              last_updated_at: DateTime,
              meta: ::Curam::ValueObjects::Meta
            )
          end
        end
      end
    end
  end
end