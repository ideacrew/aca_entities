# frozen_string_literal: true

module Ehs
  module Applications
    class ProgramApplication < Dry::Struct

      # PROGRAMAPPICATIONID
      attribute :source_system_key,       Types::String.meta(omittable: true)
      attribute :ids,             Types::Array.of(Identifiers::Id).meta(omittable: false)
      attribute :program_type,    Ehs::Types::ProgramApplicationTypeKind.meta(omittable: false)
      attribute :type_code,       Ehs::Types::ProgramApplicationTypeCodeKind.optional.meta(omittable: true)
      attribute :status,          Ehs::Types::ProgramApplicationStatusKind.meta(omittable: false)
      attribute :status_code,     Ehs::Types::ProgramApplicationStatusCodeKind.optional.meta(omittable: true)
      attribute :last_updated_at, Types::DateTime.meta(omittable: false)
      attribute :request_date,    Types::Date.optional.meta(omittable: true)
      attribute :case_decisions,  Types::Array.of(Ehs::CaseDecisions::CaseDecision).optional.meta(omittable: true)
    end
  end
end
