# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module NonEsi
      module H31
        # Entity for Fdsh Non ESI(employer sponsored insurance) ResponseMetaData
        class ResponseMetaData < Dry::Struct
          attribute :ResponseCode,  Types::String.meta(omittable: false)
          attribute :ResponseDescriptionText,  Types::String.meta(omittable: false)
          attribute :TDSResponseDescriptionText,  Types::String.optional.meta(omittable: true)
        end
      end
    end
  end
end