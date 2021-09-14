# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module H79
        # Entity for RRV IRSFileMetadata
        class IRSFileMetadata < Dry::Struct
          attribute :IRSDocumentAttachmentQuantity,  Types::Integer.meta(omittable: false)
          attribute :Attachments,  Types::Array.of(Fdsh::Rrv::H79::Attachment).meta(omittable: false)
        end
      end
    end
  end
end
