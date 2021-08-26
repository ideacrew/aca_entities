# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Esi
      module H14
        # Entity for Fdsh ESI(employer sponsored insurance) VerificationResponse
        class ResponseMetaData < Dry::Struct
          attribute :ResponseCode,  Types::String.meta(omittable: false)
          attribute :ResponseDescriptionText,  Types::String.meta(omittable: false)
        end
      end
    end
  end
end