# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module H43
        # Contract for PVC BatchMetadataContract
        class BatchMetadataContract < Dry::Validation::Contract
          params do
            required(:BatchID).maybe(:string)
            required(:BatchPartnerID).maybe(:string)
            required(:BatchAttachmentTotalQuantity).maybe(:integer)
            required(:BatchCategoryCode).maybe(:string)
            required(:BatchTransmissionQuantity).maybe(:integer)
          end
        end
      end
    end
  end
end