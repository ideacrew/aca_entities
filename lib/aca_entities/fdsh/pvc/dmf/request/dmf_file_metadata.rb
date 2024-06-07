# frozen_string_literal: true

module AcaEntities
    module Fdsh
      module Pvc
              module Dmf
          module Request
          # Entity for PVC MedicareFileMetadata
          class DMFFileMetadata < Dry::Struct
            attribute :DMFDocumentAttachmentQuantity,   Types::Integer.meta(omittable: false)
            attribute :Attachment,        Fdsh::Pvc::H43::Attachment.meta(omittable: false)
          end
        end
        end
      end
    end
  end
  