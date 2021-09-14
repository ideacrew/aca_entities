# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module H79
        # Contract for RRV BatchMetadataContract
        class BatchMetadataContract < Dry::Validation::Contract
          params do
            required(:BatchID).maybe(:string)
            required(:BatchPartnerID).maybe(:string)
            required(:BatchAttachmentTotalQuantity).maybe(:float)
            required(:BatchCategoryCode).maybe(:string)
            required(:BatchTransmissionQuantity).maybe(:float)
          end
        end
      end
    end
  end
end