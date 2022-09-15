# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Pvc
          module H43
            # Happymapper implementation for the root object of an TransmissionMetadata.
            class ServiceSpecificData
              include HappyMapper
              register_namespace 'ext', 'http://pvcreq.dsh.cms.gov/extension/1.0'
              register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'

              tag 'ServiceSpecificData'
              namespace 'ext'

              has_one :IRSFileMetadata, IrsFileMetadata
              has_one :SSAFileMetadata, SsaFileMetadata
              has_one :MedicareFileMetadata, MedicareFileMetadata
              has_one :CurrentIncomeFileMetadata, CurrentIncomeFileMetadata

              def self.domain_to_mapper(request)
                mapper = self.new
                mapper.IRSFileMetadata = IrsFileMetadata.domain_to_mapper(request.IRSFileMetadata) if request.IRSFileMetadata.present?
                mapper.SSAFileMetadata = SsaFileMetadata.domain_to_mapper(request.SSAFileMetadata) if request.SSAFileMetadata.present?
                if request.MedicareFileMetadata.present?
                  mapper.MedicareFileMetadata = MedicareFileMetadata.domain_to_mapper(request.MedicareFileMetadata)
                end
                if request.CurrentIncomeFileMetadata.present?
                  mapper.CurrentIncomeFileMetadata = CurrentIncomeFileMetadata.domain_to_mapper(request.CurrentIncomeFileMetadata)
                end

                mapper
              end
            end
          end
        end
      end
    end
  end
end