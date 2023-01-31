# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H41
      # Entity for H41 BatchHandlingServiceRequest
      class BatchHandlingServiceRequest < Dry::Struct
        attribute :BatchMetadata,  AcaEntities::Fdsh::H41::BatchMetadata.meta(omittable: false)
        attribute :TransmissionMetadata,  AcaEntities::Fdsh::H41::TransmissionMetadata.meta(omittable: false)
        attribute :ServiceSpecificData,  AcaEntities::Fdsh::H41::ServiceSpecificData.optional.meta(omittable: true)
        attribute :Attachments,  Types::Array.of(AcaEntities::Fdsh::H41::Attachment).optional.meta(omittable: false)
      end
    end
  end
end
