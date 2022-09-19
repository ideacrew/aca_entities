# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module H43
        # Contract for PVC BatchHandlingServiceRequestContract
        class BatchHandlingServiceRequestContract < Dry::Validation::Contract
          params do
            required(:BatchMetadata).filled(AcaEntities::Fdsh::Pvc::H43::BatchMetadataContract.params)
            required(:TransmissionMetadata).filled(AcaEntities::Fdsh::Pvc::H43::TransmissionMetadataContract.params)
            required(:ServiceSpecificData).maybe(AcaEntities::Fdsh::Pvc::H43::ServiceSpecificDataContract.params)
            optional(:Attachment).array(AcaEntities::Fdsh::Pvc::H43::AttachmentContract.params)
          end
        end
      end
    end
  end
end