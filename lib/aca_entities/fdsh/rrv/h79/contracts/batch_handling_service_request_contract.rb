# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module H79
        # Contract for RRV BatchHandlingServiceRequestContract
        class BatchHandlingServiceRequestContract < Dry::Validation::Contract
          params do
            required(:BatchMetadata).filled(AcaEntities::Fdsh::Rrv::H79::BatchMetadataContract.params)
            required(:TransmissionMetadata).filled(AcaEntities::Fdsh::Rrv::H79::TransmissionMetadataContract.params)
            required(:ServiceSpecificData).maybe(AcaEntities::Fdsh::Rrv::H79::ServiceSpecificDataContract.params)
            optional(:Attachment).array(AcaEntities::Fdsh::Rrv::H79::AttachmentContract.params)
          end
        end
      end
    end
  end
end