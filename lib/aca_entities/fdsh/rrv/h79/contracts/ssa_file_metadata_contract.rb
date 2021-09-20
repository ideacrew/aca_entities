# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module H79
        # Contract for RRV SSAFileMetadataContract
        class SSAFileMetadataContract < Dry::Validation::Contract
          params do
            required(:SSADocumentAttachmentQuantity).filled(:integer)
            required(:Attachment).filled(AcaEntities::Fdsh::Rrv::H79::AttachmentContract.params)
          end
        end
      end
    end
  end
end