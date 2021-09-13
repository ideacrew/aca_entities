# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module H79
        # Entity for RRV BatchHandlingServiceRequest
        class BatchHandlingServiceRequest < Dry::Struct
          attribute :BatchMetadata,  Fdsh::Rrv::H79::BatchMetadata.meta(omittable: false)
          attribute :TransmissionMetadata,  Fdsh::Rrv::H79::TransmissionMetadata.meta(omittable: false)
          attribute :ServiceSpecificData,  Fdsh::Rrv::H79::ServiceSpecificData.optional.meta(omittable: false)
          attribute :Attachment,  Types::Array.of(Fdsh::Rrv::H79::Attachment).optional.meta(omittable: true)
        end
      end
    end
  end
end