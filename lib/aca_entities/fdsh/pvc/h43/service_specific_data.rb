# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module H43
        # Entity for PVC ServiceSpecificData
        class ServiceSpecificData < Dry::Struct
          attribute :IRSFileMetadata,   Fdsh::Pvc::H43::IRSFileMetadata.optional.meta(omittable: true)
          attribute :SSAFileMetadata,  Fdsh::Pvc::H43::SSAFileMetadata.optional.meta(omittable: true)
          attribute :MedicareFileMetadata,   Fdsh::Pvc::H43::MedicareFileMetadata.optional.meta(omittable: true)
          attribute :CurrentIncomeFileMetadata,   Fdsh::Pvc::H43::CurrentIncomeFileMetadata.optional.meta(omittable: true)
          attribute :ResponseMetadata,   Fdsh::Pvc::H43::ResponseMetadata.optional.meta(omittable: true)
          attribute :EFTFileName,   AcaEntities::Types::String.optional.meta(omittable: true)
        end
      end
    end
  end
end
