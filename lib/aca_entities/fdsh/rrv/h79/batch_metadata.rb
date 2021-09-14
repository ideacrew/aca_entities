# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module H79
        # Entity for RRV BatchMetadata
        class BatchMetadata < Dry::Struct
          attribute :BatchID,  AcaEntities::Types::String.optional.meta(omittable: false)
          attribute :BatchPartnerID,  AcaEntities::Types::String.optional.meta(omittable: false)
          attribute :BatchAttachmentTotalQuantity,  Types::Float.optional.meta(omittable: false)
          attribute :BatchCategoryCode,  AcaEntities::Types::String.optional.meta(omittable: false)
          attribute :BatchTransmissionQuantity,  Types::Float.optional.meta(omittable: false)
        end
      end
    end
  end
end