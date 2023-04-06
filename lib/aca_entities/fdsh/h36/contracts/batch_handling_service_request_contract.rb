# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      module Contracts
        # Contract for H36 BatchHandlingServiceRequestContract
        class BatchHandlingServiceRequestContract < Dry::Validation::Contract
          params do
            required(:BatchMetadata).filled(AcaEntities::Fdsh::H36::Contracts::BatchMetadataContract.params)
            required(:TransmissionMetadata).filled(AcaEntities::Fdsh::H36::Contracts::TransmissionMetadataContract.params)
            required(:ServiceSpecificData).maybe(AcaEntities::Fdsh::H36::Contracts::ServiceSpecificDataContract.params)
            required(:Attachments).array(AcaEntities::Fdsh::H36::Contracts::AttachmentContract.params)
          end
        end
      end
    end
  end
end
