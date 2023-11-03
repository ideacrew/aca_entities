# frozen_string_literal: true

module AcaEntities
  module Evidences
    # Entity for FARS Evidence
    class FarsEvidence < Dry::Struct

      attribute :fars_request, AcaEntities::Fdsh::Ridp::H140::FarsRequest.optional.meta(omittable: true)
      attribute :fars_response, AcaEntities::Fdsh::Ridp::H140::FarsResponse.optional.meta(omittable: true)
    end
  end
end
