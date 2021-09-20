# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module H79
        # Contract for RRV MedicareFileMetadataContract
        class MedicareFileMetadataContract < Dry::Validation::Contract
          params do
            required(:MedicareDocumentAttachmentQuantity).filled(:integer)
            required(:Attachment).filled(AcaEntities::Fdsh::Rrv::H79::AttachmentContract.params)
          end
        end
      end
    end
  end
end