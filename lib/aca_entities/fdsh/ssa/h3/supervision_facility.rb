# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        # Entity for Fdsh SSAVerification Response
        class SupervisionFacility < Dry::Struct

          attribute :FacilityName,  Types::String.meta(omittable: false)
          attribute :FacilityLocation,  AcaEntities::Fdsh::Ssa::H3::FacilityLocation.meta(omittable: false)
          attribute :FacilityContactInformation,  AcaEntities::Fdsh::Ssa::H3::FacilityContactInformation.meta(omittable: false)
          attribute :FacilityCategoryCode, Types::String.meta(omittable: false)
        end
      end
    end
  end
end