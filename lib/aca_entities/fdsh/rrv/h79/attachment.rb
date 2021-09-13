# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module H79
        # Entity for RRV Attachment
        class Attachment < Dry::Struct
          attribute :DocumentBinary,  Fdsh::Rrv::H79::DocumentBinary.optional.meta(omittable: true)
          attribute :DocumentFileName,  AcaEntities::Types::String.meta(omittable: false)
          attribute :DocumentSequenceID,  AcaEntities::Types::String.meta(omittable: false)
          attribute :DocumentRecordCount,  AcaEntities::Types::Integer.optional.meta(omittable: true)
          attribute :ResponseMetadata,  Fdsh::Rrv::H79::ResponseMetadata.optional.meta(omittable: true)
        end
      end
    end
  end
end
