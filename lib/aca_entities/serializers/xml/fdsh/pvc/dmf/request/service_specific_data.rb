# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Pvc
          module Dmf
            module Request
              # Happymapper implementation for the root object of an TransmissionMetadata.
              class ServiceSpecificData
                include HappyMapper
                register_namespace 'ext', 'http://pvcreq.dsh.cms.gov/extension/1.0'
                register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'

                tag 'ServiceSpecificData'
                namespace 'ext'

                has_one :DMFFileMetadata, DMFFileMetadata

                def self.domain_to_mapper(request)
                  mapper = self.new
                  if request.DMFFileMetadata.present?
                    mapper.DMFFileMetadata = DMFFileMetadata.domain_to_mapper(request.DMFFileMetadata)
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
end