# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module H43
        # Entity for PVC SSAFileMetadata
        class SSAFileMetadata < Dry::Struct
          attribute :SSADocumentAttachmentQuantity,   Types::Integer.meta(omittable: false)
          attribute :Attachment,        Fdsh::Pvc::H43::Attachment.meta(omittable: false)
        end
      end
    end
  end
end
