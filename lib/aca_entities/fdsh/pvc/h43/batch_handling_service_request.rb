# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module H43
        # Entity for PVC BatchHandlingServiceRequest
        class BatchHandlingServiceRequest < Dry::Struct
          attribute :BatchMetadata,  Fdsh::Pvc::H43::BatchMetadata.meta(omittable: false)
          attribute :TransmissionMetadata,  Fdsh::Pvc::H43::TransmissionMetadata.meta(omittable: false)
          attribute :ServiceSpecificData,  Fdsh::Pvc::H43::ServiceSpecificData.optional.meta(omittable: true)
          attribute :Attachments,  Types::Array.of(Fdsh::Pvc::H43::Attachment).optional.meta(omittable: true)
        end
      end
    end
  end
end