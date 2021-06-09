# frozen_string_literal: true

module AcaEntities
  module Evidences
    # contract for RidpEvidence
    class RidpEvidenceContract < Dry::Validation::Contract

      params do
        optional(:primary_request).maybe(AcaEntities::Fdsh::Ridp::H139::PrimaryRequestContract.params)
        optional(:primary_response).maybe(AcaEntities::Fdsh::Ridp::H139::PrimaryResponseContract.params)
        optional(:secondary_request).maybe(AcaEntities::Fdsh::Ridp::H139::SecondaryRequestContract.params)
        optional(:secondary_response).maybe(AcaEntities::Fdsh::Ridp::H139::SecondaryResponseContract.params)
      end
    end
  end
end
