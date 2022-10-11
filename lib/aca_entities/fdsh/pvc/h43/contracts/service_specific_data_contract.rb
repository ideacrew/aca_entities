# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module H43
        # Contract for PVC ServiceSpecificDataContract
        class ServiceSpecificDataContract < Dry::Validation::Contract
          params do
            optional(:IRSFileMetadata).maybe(AcaEntities::Fdsh::Pvc::H43::IRSFileMetadataContract.params)
            optional(:SSAFileMetadata).maybe(AcaEntities::Fdsh::Pvc::H43::SSAFileMetadataContract.params)
            optional(:MedicareFileMetadata).maybe(AcaEntities::Fdsh::Pvc::H43::MedicareFileMetadataContract.params)
            optional(:CurrentIncomeFileMetadata).maybe(AcaEntities::Fdsh::Pvc::H43::CurrentIncomeFileMetadataContract.params)
            optional(:ResponseMetadata).maybe(AcaEntities::Fdsh::Pvc::H43::ResponseMetadataContract.params)
            optional(:EFTFileName).maybe(:string)
          end
        end
      end
    end
  end
end