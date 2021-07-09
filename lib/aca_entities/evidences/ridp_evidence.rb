# frozen_string_literal: true

module AcaEntities
  module Evidences
    # Entity for RidpEvidence
    class RidpEvidence < Dry::Struct

      attribute :primary_request,       AcaEntities::Fdsh::Ridp::H139::PrimaryRequest.optional.meta(omittable: true)
      attribute :primary_response,      AcaEntities::Fdsh::Ridp::H139::PrimaryResponse.optional.meta(omittable: true)
      attribute :secondary_request,     AcaEntities::Fdsh::Ridp::H139::SecondaryRequest.optional.meta(omittable: true)
      attribute :secondary_response,    AcaEntities::Fdsh::Ridp::H139::SecondaryResponse.optional.meta(omittable: true)
    end
  end
end
