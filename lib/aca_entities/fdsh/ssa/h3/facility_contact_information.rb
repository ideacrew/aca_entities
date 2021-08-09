# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        # Entity for Fdsh SSAVerification Response
        class FacilityContactInformation < Dry::Struct

          attribute :PersonFullName,  Types::String.meta(omittable: false)
          attribute :ContactTelephoneNumber,  Types::String.meta(omittable: false)
          attribute :ContactFaxNumber,  Types::String.meta(omittable: false)
        end
      end
    end
  end
end