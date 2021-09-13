# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module H79
        # Entity for RRV CurrentIncomeFileMetadata
        class CurrentIncomeFileMetadata < Dry::Struct
          attribute :CurrentIncomeDocumentAttachmentQuantity,   AcaEntities::Types::Decimal.meta(omittable: false)
          attribute :Attachment,        Fdsh::Rrv::H79::Attachment.meta(omittable: false)
        end
      end
    end
  end
end
