# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module H79
        # Contract for RRV TransmissionMetadataContract
        class TransmissionMetadataContract < Dry::Validation::Contract
          params do
            required(:TransmissionAttachmentQuantity).filled(:integer)
            required(:TransmissionSequenceID).filled(:integer)
          end
        end
      end
    end
  end
end