# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module H43
        # Contract for PVC IRSFileMetadataContract
        class IRSFileMetadataContract < Dry::Validation::Contract
          params do
            required(:IRSDocumentAttachmentQuantity).filled(:integer)
            required(:Attachments).array(AcaEntities::Fdsh::Pvc::H43::AttachmentContract.params)
          end
        end
      end
    end
  end
end