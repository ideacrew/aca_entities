# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module ParticipantRoles
        # entity for ParticipantRole
        class ParticipantRole < Dry::Struct

          attribute :source_system_key,   Types::String.optional.meta(omittable: true)
          attribute :ids,                 Types::Array.of(Curam::Identifiers::Id).meta(omittable: false)
          attribute :record_status,       Types::ParticipantRoleStatusKind.meta(omittable: false)
          attribute :record_status_code,  Types::ParticipantRoleStatusCodeKind.optional.meta(omittable: true)
          attribute :last_updated_at,     Types::DateTime.meta(omittable: false)
          attribute :version,             Types::Integer.meta(omittable: false)
          attribute :person,              Curam::People::Person.meta(omittable: false)
          attribute :role_name,           Types::ParticipantRoleNameKind.meta(omittable: false)
          attribute :type_code,           Types::ParticipantRoleTypeCodeKind.optional.meta(omittable: true)

          def primary_client?
            role_name == 'Primary Client'
          end
        end
      end
    end
  end
end
