# frozen_string_literal: true

module Ehs
  module Evidences
    class EvidenceContract < Ehs::ApplicationContract

      params do
        required(:ids).array(:hash)
        required(:evidence_status).filled(Ehs::Types::EvidenceStatusType)
        required(:version_number).filled(:integer)
        required(:category).filled(Ehs::Types::EvidenceCategoryKind)
        required(:last_updated_at).maybe(:date_time)
      end
    end
  end
end
