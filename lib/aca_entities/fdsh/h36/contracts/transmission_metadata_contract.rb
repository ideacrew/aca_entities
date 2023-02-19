# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      module Contracts
        # Contract for H36 TransmissionMetadataContract
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