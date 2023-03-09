# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      module Contracts
        # Contract for H36 BatchHandlingServiceRequestContract
        class BatchHandlingServiceRequestContract < Dry::Validation::Contract
          params do
            required(:BatchMetadata).filled(AcaEntities::Fdsh::H41::Contracts::BatchMetadataContract.params)
            required(:TransmissionMetadata).filled(AcaEntities::Fdsh::H41::Contracts::TransmissionMetadataContract.params)
            required(:ServiceSpecificData).maybe(AcaEntities::Fdsh::H41::Contracts::ServiceSpecificDataContract.params)
            required(:Attachments).array(AcaEntities::Fdsh::H41::Contracts::AttachmentContract.params)
          end
        end
      end
    end
  end
end