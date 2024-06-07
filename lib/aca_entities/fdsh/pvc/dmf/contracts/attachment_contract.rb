# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module Dmf
  module Contracts
        # Contract for PVC AttachmentContract
        class AttachmentContract < Dry::Validation::Contract
          params do
            required(:DocumentBinary).filled(AcaEntities::Fdsh::Pvc::Dmf::Contracts::DocumentBinaryContract.params)
            required(:DocumentFileName).filled(:string)
            required(:DocumentSequenceID).filled(:string)
            required(:DocumentRecordCount).filled(:integer)
            optional(:ResponseMetadata).maybe(AcaEntities::Fdsh::Pvc::Dmf::Contracts::ResponseMetadataContract.params)
          end
        end
      end
      end
    end
  end
end