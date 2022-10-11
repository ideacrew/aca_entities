# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module H43
        # Entity for PVC CurrentIncomeFileMetadataContract
        class CurrentIncomeFileMetadataContract < Dry::Validation::Contract
          params do
            required(:CurrentIncomeDocumentAttachmentQuantity).filled(:integer)
            required(:Attachment).filled(AcaEntities::Fdsh::Pvc::H43::AttachmentContract.params)
          end
        end
      end
    end
  end
end
