# frozen_string_literal: true

module Ehs
  module ParticipantRoles
    module Commands
      class CreateRole < Sequent::Command
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

        include ::Ehs::Commands::QuackLikeACreateOperation
      end

      class UpdateRole < Sequent::Command
        attrs(
          record_status: String,
          version: String,
          last_updated_at: DateTime,
          meta: ::Ehs::ValueObjects::Meta
        )

        include ::Ehs::Commands::QuackLikeAnOperation
      end
    end
  end
end