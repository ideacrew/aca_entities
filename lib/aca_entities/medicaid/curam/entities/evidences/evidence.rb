# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Evidences
        # mentity for curam Evidence
        class Evidence < Dry::Struct

          # CASEREFERENCE, EVIDENCEDESCRIPTORID
          attribute :ids,                      Types::Array.of(Identifiers::Id).optional.meta(omittable: true)
          attribute :last_updated_at,          Types::DateTime.meta(omittable: false)
          attribute :evidence_status,          Curam::TypesEvidenceStatusType.meta(omittable: false)
          attribute :version_number,           Types::Integer.meta(omittable: false)
          attribute :person,                   People::Person.optional.meta(omittable: true)
        end
      end
    end
  end
end
