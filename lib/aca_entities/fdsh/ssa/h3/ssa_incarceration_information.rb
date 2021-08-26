# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        # Entity for Fdsh SSAVerification Response
        class SSAIncarcerationInformation < Dry::Struct

          attribute :PrisonerIdentification,  Types::String.meta(omittable: false)
          attribute :PrisonerConfinementDate,  Types::String.meta(omittable: false)
          attribute :ReportingPersonText,  Types::String.meta(omittable: false)
          attribute :SupervisionFacility,  AcaEntities::Fdsh::Ssa::H3::SupervisionFacility.meta(omittable: false)
          attribute :InmateStatusIndicator, Types::Bool.meta(omittable: false)
        end
      end
    end
  end
end