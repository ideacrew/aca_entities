# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module H79
        # Entity for RRV CurrentIncomeFileMetadataContract
        class CurrentIncomeFileMetadataContract < Dry::Validation::Contract
          params do
            required(:CurrentIncomeDocumentAttachmentQuantity).filled(:integer)
            required(:Attachment).filled(AcaEntities::Fdsh::Rrv::H79::AttachmentContract.params)
          end
        end
      end
    end
  end
end
