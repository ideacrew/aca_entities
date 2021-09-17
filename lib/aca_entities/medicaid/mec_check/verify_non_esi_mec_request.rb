# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module MecCheck
      # entity for VerifyNonEsiMecRequest
      class VerifyNonEsiMecRequest < Dry::Struct
        attribute :non_esi_mec_request, NonEsiMecRequest.meta(omittable: false)
      end
    end
  end
end