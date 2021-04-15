# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Evidences
        # contract for curam Evidence
        class EvidenceContract < Curam::ApplicationContract

          params do
            required(:ids).array(:hash)
            required(:evidence_status).filled(Curam::TypesEvidenceStatusType)
            required(:version_number).filled(:integer)
            required(:category).filled(Curam::TypesEvidenceCategoryKind)
            required(:last_updated_at).maybe(:date_time)
          end
        end
      end
    end
  end
end
