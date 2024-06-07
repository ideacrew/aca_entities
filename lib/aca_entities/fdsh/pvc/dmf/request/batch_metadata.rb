# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module Dmf
        module Request
        # Entity for PVC BatchMetadata
        class BatchMetadata < Dry::Struct
          attribute :BatchID,  AcaEntities::Types::String.optional.meta(omittable: false)
          attribute :BatchPartnerID,  AcaEntities::Types::String.optional.meta(omittable: false)
          attribute :BatchAttachmentTotalQuantity,  Types::Integer.optional.meta(omittable: false)
          attribute :BatchCategoryCode,  AcaEntities::Types::String.optional.meta(omittable: false)
          attribute :BatchTransmissionQuantity,  Types::Integer.optional.meta(omittable: false)
        end
      end
      end
    end
  end
end