# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module H43
        # Contract for PVC SSAFileMetadataContract
        class SSAFileMetadataContract < Dry::Validation::Contract
          params do
            required(:SSADocumentAttachmentQuantity).filled(:integer)
            required(:Attachment).filled(AcaEntities::Fdsh::Pvc::H43::AttachmentContract.params)
          end
        end
      end
    end
  end
end