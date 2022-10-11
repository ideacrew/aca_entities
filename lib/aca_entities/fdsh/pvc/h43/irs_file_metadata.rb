# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module H43
        # Entity for PVC IRSFileMetadata
        class IRSFileMetadata < Dry::Struct
          attribute :IRSDocumentAttachmentQuantity,  Types::Integer.meta(omittable: false)
          attribute :Attachments,  Types::Array.of(Fdsh::Pvc::H43::Attachment).meta(omittable: false)
        end
      end
    end
  end
end
