# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Pvc
          module H43
            module Response
              # Happymapper implementation for the root object of an ResponseAttachment.
              class ResponseAttachment
                include HappyMapper
                register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'
                register_namespace 'ext', 'http://rrvhtorresp.dsh.cms.gov/extension/1.0'
                register_namespace 'Q1', 'http://niem.gov/niem/niem-core/2.0'

                tag 'Attachment'
                namespace 'ext'

                has_one :DocumentBinary, DocumentBinary
                element :DocumentFileName, String, tag: 'DocumentFileName', namespace: 'Q1'
                element :DocumentSequenceID, String, tag: 'DocumentSequenceID', namespace: 'Q1'
                has_one :ResponseMetadata, ResponseMetadata

                def self.domain_to_mapper(response)
                  mapper = self.new
                  mapper.DocumentBinary = DocumentBinary.domain_to_mapper(response.DocumentBinary) if response.DocumentBinary
                  mapper.DocumentFileName = response.DocumentFileName if response.DocumentFileName
                  mapper.DocumentSequenceID = response.DocumentSequenceID if response.DocumentSequenceID
                  mapper.ResponseMetadata = ResponseMetadata.domain_to_mapper(response.ResponseMetadata) if response.ResponseMetadata

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