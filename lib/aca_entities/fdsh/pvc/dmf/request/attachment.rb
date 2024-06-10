# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module Dmf
        module Request
          # Entity for PVC Attachment
          class Attachment < Dry::Struct
            attribute :DocumentBinary,  Fdsh::Pvc::H43::DocumentBinary.optional.meta(omittable: true)
            attribute :DocumentFileName,  AcaEntities::Types::String.meta(omittable: false)
            attribute :DocumentSequenceID,  AcaEntities::Types::String.meta(omittable: false)
            attribute :DocumentRecordCount,  AcaEntities::Types::Integer.optional.meta(omittable: true)
            attribute :ResponseMetadata,  Fdsh::Pvc::H43::ResponseMetadata.optional.meta(omittable: true)
          end
        end
      end
    end
  end
end
