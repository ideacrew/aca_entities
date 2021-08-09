# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        # Entity for Fdsh SSAVerification Response
        class FacilityLocation < Dry::Struct

          attribute :LocationStreet,  Types::String.meta(omittable: false)
          attribute :LocationCityName,  Types::String.meta(omittable: false)
          attribute :LocationStateUSPostalServiceCode,  Types::String.meta(omittable: false)
          attribute :LocationPostalCode,  Types::String.meta(omittable: false)
          attribute :LocationPostalExtensionCode,  Types::String.meta(omittable: false)

        end
      end
    end
  end
end