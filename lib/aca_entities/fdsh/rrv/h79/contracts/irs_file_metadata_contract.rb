# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module H79
        # Contract for RRV IRSFileMetadataContract
        class IRSFileMetadataContract < Dry::Validation::Contract
          params do
            required(:IRSDocumentAttachmentQuantity).filled(:integer)
            required(:Attachments).array(AcaEntities::Fdsh::Rrv::H79::AttachmentContract.params)
          end
        end
      end
    end
  end
end