# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Pvc
          module Dmf
            module Response
              module Manifest
                # Happymapper implementation for the root object of an ServiceSpecificData.
                class ServiceSpecificData
                  include HappyMapper
                  register_namespace 'ext', 'http://pvchtorresp.dsh.cms.gov/extension/1.0'
                  register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'

                  tag 'ServiceSpecificData'
                  namespace 'ext'

                  has_one :ResponseMetadata, ResponseMetadata
                  element :EFTFileName, String, tag: 'EFTFileName', namespace: 'ext'

                  def self.domain_to_mapper(request)
                    mapper = self.new
                    mapper.ResponseMetadata = ResponseMetadata.domain_to_mapper(request.ResponseMetadata) if request&.ResponseMetadata&.present?
                    mapper.EFTFileName = request.EFTFileName if request&.EFTFileName&.present?

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
end