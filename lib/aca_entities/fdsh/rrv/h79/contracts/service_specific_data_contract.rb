# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module H79
        # Contract for RRV ServiceSpecificDataContract
        class ServiceSpecificDataContract < Dry::Validation::Contract
          params do
            optional(:IRSFileMetadata).maybe(AcaEntities::Fdsh::Rrv::H79::IRSFileMetadataContract.params)
            optional(:SSAFileMetadata).maybe(AcaEntities::Fdsh::Rrv::H79::SSAFileMetadataContract.params)
            optional(:MedicareFileMetadata).maybe(AcaEntities::Fdsh::Rrv::H79::MedicareFileMetadataContract.params)
            optional(:CurrentIncomeFileMetadata).maybe(AcaEntities::Fdsh::Rrv::H79::CurrentIncomeFileMetadataContract.params)
            optional(:ResponseMetadata).maybe(AcaEntities::Fdsh::Rrv::H79::ResponseMetadataContract.params)
            optional(:EFTFileName).maybe(:string)
          end
        end
      end
    end
  end
end