# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module Dmf
  module Contracts
        # Contract for DMF FileMetadataContract
        class DMFFileMetadataContract < Dry::Validation::Contract
          params do
            required(:DMFDocumentAttachmentQuantity).filled(:integer)
            required(:Attachment).filled(AcaEntities::Fdsh::Pvc::Dmf::Contracts::AttachmentContract.params)
          end
        end
      end
    end
    end
  end
end