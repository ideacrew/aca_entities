# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module H79
        # Entity for RRV IRSFileMetadata
        class IRSFileMetadata < Dry::Struct
          attribute :IRSDocumentAttachmentQuantity,   AcaEntities::Types::Decimal.meta(omittable: false)
          attribute :Attachment,  Types::Array.of(Fdsh::Rrv::H79::Attachment).meta(omittable: false)
        end
      end
    end
  end
end
