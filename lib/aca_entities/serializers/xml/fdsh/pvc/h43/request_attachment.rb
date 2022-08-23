# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Pvc
          module H43
            # Happymapper implementation for the root object of an BatchHandlingServiceRequest.
            class RequestAttachment
              include HappyMapper
              register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'
              register_namespace 'ext', 'http://rrvreq.dsh.cms.gov/extension/1.0'
              register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'

              tag 'Attachment'
              namespace 'ext'

              has_one :DocumentBinary, DocumentBinary
              element :DocumentFileName, String, tag: 'DocumentFileName', namespace: 'nc'
              element :DocumentSequenceID, String, tag: 'DocumentSequenceID', namespace: 'nc'
              element :DocumentRecordCount, Integer, tag: 'DocumentRecordCount', namespace: 'ext'

              def self.domain_to_mapper(request)
                mapper = self.new
                mapper.DocumentBinary = DocumentBinary.domain_to_mapper(request.DocumentBinary) if request.DocumentBinary
                mapper.DocumentFileName = request.DocumentFileName if request.DocumentFileName
                mapper.DocumentSequenceID = request.DocumentSequenceID if request.DocumentSequenceID
                mapper.DocumentRecordCount = request.DocumentRecordCount if request.DocumentRecordCount

                mapper
              end
            end
          end
        end
      end
    end
  end
end