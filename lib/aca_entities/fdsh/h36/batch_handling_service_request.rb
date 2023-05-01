# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      # Entity for H36 BatchHandlingServiceRequest
      class BatchHandlingServiceRequest < Dry::Struct
        attribute :BatchMetadata,  AcaEntities::Fdsh::H36::BatchMetadata.meta(omittable: false)
        attribute :TransmissionMetadata,  AcaEntities::Fdsh::H36::TransmissionMetadata.meta(omittable: false)
        attribute :ServiceSpecificData,  AcaEntities::Fdsh::H36::ServiceSpecificData.optional.meta(omittable: true)
        attribute :Attachments,  Types::Array.of(AcaEntities::Fdsh::H36::Attachment).optional.meta(omittable: false)
      end
    end
  end
end