# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
            module Dmf
        module Request
        # Entity for PVC ServiceSpecificData
        class ServiceSpecificData < Dry::Struct
          attribute :DMFFileMetadata,   Fdsh::Pvc::Dmf::Request::DMFFileMetadata.optional.meta(omittable: true)
          attribute :ResponseMetadata,   Fdsh::Pvc::Dmf::Request::ResponseMetadata.optional.meta(omittable: true)
          attribute :EFTFileName,   AcaEntities::Types::String.optional.meta(omittable: true)
        end
      end
      end
    end
  end
end
