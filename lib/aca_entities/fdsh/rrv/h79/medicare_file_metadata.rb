# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module H79
        # Entity for RRV MedicareFileMetadata
        class MedicareFileMetadata < Dry::Struct
          attribute :MedicareDocumentAttachmentQuantity,   AcaEntities::Types::Decimal.meta(omittable: false)
          attribute :Attachment,        Fdsh::Rrv::H79::Attachment.meta(omittable: false)
        end
      end
    end
  end
end
