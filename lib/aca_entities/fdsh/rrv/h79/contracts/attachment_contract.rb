# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module H79
        # Contract for RRV AttachmentContract
        class AttachmentContract < Dry::Validation::Contract
          params do
            required(:DocumentBinary).filled(AcaEntities::Fdsh::Rrv::H79::DocumentBinaryContract.params)
            required(:DocumentFileName).filled(:string)
            required(:DocumentSequenceID).filled(:string)
            required(:DocumentRecordCount).filled(:integer)
            optional(:ResponseMetadata).maybe(AcaEntities::Fdsh::Rrv::H79::ResponseMetadataContract.params)
          end
        end
      end
    end
  end
end