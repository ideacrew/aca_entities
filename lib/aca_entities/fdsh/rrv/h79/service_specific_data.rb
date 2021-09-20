# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module H79
        # Entity for RRV ServiceSpecificData
        class ServiceSpecificData < Dry::Struct
          attribute :IRSFileMetadata,   Fdsh::Rrv::H79::IRSFileMetadata.optional.meta(omittable: true)
          attribute :SSAFileMetadata,  Fdsh::Rrv::H79::SSAFileMetadata.optional.meta(omittable: true)
          attribute :MedicareFileMetadata,   Fdsh::Rrv::H79::MedicareFileMetadata.optional.meta(omittable: true)
          attribute :CurrentIncomeFileMetadata,   Fdsh::Rrv::H79::CurrentIncomeFileMetadata.optional.meta(omittable: true)
          attribute :ResponseMetadata,   Fdsh::Rrv::H79::ResponseMetadata.optional.meta(omittable: true)
          attribute :EFTFileName,   AcaEntities::Types::String.optional.meta(omittable: true)
        end
      end
    end
  end
end
