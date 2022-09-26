# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module H43
        # Contract for PVC AttachmentContract
        class AttachmentContract < Dry::Validation::Contract
          params do
            required(:DocumentBinary).filled(AcaEntities::Fdsh::Pvc::H43::DocumentBinaryContract.params)
            required(:DocumentFileName).filled(:string)
            required(:DocumentSequenceID).filled(:string)
            required(:DocumentRecordCount).filled(:integer)
            optional(:ResponseMetadata).maybe(AcaEntities::Fdsh::Pvc::H43::ResponseMetadataContract.params)
          end
        end
      end
    end
  end
end