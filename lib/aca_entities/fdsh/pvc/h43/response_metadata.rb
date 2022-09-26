# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module H43
        # Entity for PVC ResponseMetadata
        class ResponseMetadata < Dry::Struct
          attribute :ResponseCode,  Types::String.meta(omittable: false)
          attribute :ResponseDescriptionText,  Types::String.meta(omittable: false)
          attribute :TDSResponseDescriptionText,  Types::String.optional.meta(omittable: true)
        end
      end
    end
  end
end
