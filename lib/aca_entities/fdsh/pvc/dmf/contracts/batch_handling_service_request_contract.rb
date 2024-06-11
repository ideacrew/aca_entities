# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module Dmf
        module Contracts
          # Contract for PVC BatchHandlingServiceRequestContract
          class BatchHandlingServiceRequestContract < Dry::Validation::Contract
            params do
              required(:BatchMetadata).filled(AcaEntities::Fdsh::Pvc::Dmf::Contracts::BatchMetadataContract.params)
              required(:TransmissionMetadata).filled(AcaEntities::Fdsh::Pvc::Dmf::Contracts::TransmissionMetadataContract.params)
              required(:ServiceSpecificData).maybe(AcaEntities::Fdsh::Pvc::Dmf::Contracts::ServiceSpecificDataContract.params)
              optional(:Attachment).array(AcaEntities::Fdsh::Pvc::Dmf::Contracts::AttachmentContract.params)
            end
          end
        end
      end
    end
  end
end