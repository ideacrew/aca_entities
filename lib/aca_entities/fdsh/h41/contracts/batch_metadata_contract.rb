# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H41
      module Contracts
        # Contract for H41 BatchMetadataContract
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