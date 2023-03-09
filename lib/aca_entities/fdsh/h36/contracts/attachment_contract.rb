# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      module Contracts
        # Contract for H36 AttachmentContract
        class AttachmentContract < Dry::Validation::Contract
          params do
            required(:DocumentBinary).filled(AcaEntities::Fdsh::H41::Contracts::DocumentBinaryContract.params)
            required(:DocumentFileName).filled(:string)
            required(:DocumentSequenceID).filled(:string)
          end
        end
      end
    end
  end
end