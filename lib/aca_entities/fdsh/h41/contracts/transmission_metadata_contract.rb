# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H41
      module Contracts
        # Contract for H41 TransmissionMetadataContract
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