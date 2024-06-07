# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module Dmf
        module Request
        # Entity for PVC BatchHandlingServiceRequest
        class BatchHandlingServiceRequest < Dry::Struct
          attribute :BatchMetadata,  Fdsh::Pvc::Dmf::Request::BatchMetadata.meta(omittable: false)
          attribute :TransmissionMetadata,  Fdsh::Pvc::Dmf::Request::TransmissionMetadata.meta(omittable: false)
          attribute :ServiceSpecificData,  Fdsh::Pvc::Dmf::Request::ServiceSpecificData.optional.meta(omittable: true)
          attribute :Attachments,  Types::Array.of(Fdsh::Pvc::Dmf::Request::Attachment).optional.meta(omittable: true)
        end
      end
    end
    end
  end
end