# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module Dmf
        module Contracts
          # Contract for PVC TransmissionMetadataContract
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
end