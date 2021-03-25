# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Applications
        # entity for ProgramApplication
        class ProgramApplication < Dry::Struct

          # PROGRAMAPPICATIONID
          attribute :source_system_key,       Types::String.meta(omittable: true)
          attribute :ids,             Types::Array.of(Identifiers::Id).meta(omittable: false)
          attribute :program_type,    Curam::TypesProgramApplicationTypeKind.meta(omittable: false)
          attribute :type_code,       Curam::TypesProgramApplicationTypeCodeKind.optional.meta(omittable: true)
          attribute :status,          Curam::TypesProgramApplicationStatusKind.meta(omittable: false)
          attribute :status_code,     Curam::TypesProgramApplicationStatusCodeKind.optional.meta(omittable: true)
          attribute :last_updated_at, Types::DateTime.meta(omittable: false)
          attribute :request_date,    Types::Date.optional.meta(omittable: true)
          attribute :case_decisions,  Types::Array.of(Curam::CaseDecisions::CaseDecision).optional.meta(omittable: true)
        end
      end
    end
  end
end
