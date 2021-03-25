# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module ParticipantRoles
        module Commands
          # CreateRole command
          class CreateRole < Sequent::Command
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

            include ::Curam::Commands::QuackLikeACreateOperation
          end

          class UpdateRole < Sequent::Command
            attrs(
              record_status: String,
              version: String,
              last_updated_at: DateTime,
              meta: ::Curam::ValueObjects::Meta
            )

            include ::Curam::Commands::QuackLikeAnOperation
          end
        end
      end
    end
  end
end