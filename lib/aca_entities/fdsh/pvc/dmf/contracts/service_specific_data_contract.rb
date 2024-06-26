# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module Dmf
        module Contracts
          # Contract for PVC ServiceSpecificDataContract
          class ServiceSpecificDataContract < Dry::Validation::Contract
            params do
              optional(:DMFFileMetadata).maybe(AcaEntities::Fdsh::Pvc::Dmf::Contracts::DMFFileMetadataContract.params)
              optional(:ResponseMetadata).maybe(AcaEntities::Fdsh::Pvc::Dmf::Contracts::ResponseMetadataContract.params)
              optional(:EFTFileName).maybe(:string)
            end
          end
        end
      end
    end
  end
end