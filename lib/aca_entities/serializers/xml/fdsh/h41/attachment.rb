# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module H41
          # Happymapper implementation for the root object of an Attachment.
          class Attachment
            include HappyMapper
            register_namespace 'ns4', "http://birsrep.dsh.cms.gov/extension/1.0"
            register_namespace 'ns5', "http://niem.gov/niem/niem-core/2.0"

            tag 'Attachment'
            namespace 'ns4'

            has_one :DocumentBinary, DocumentBinary
            element :DocumentFileName, String, tag: 'DocumentFileName', namespace: 'ns5'
            element :DocumentSequenceID, String, tag: 'DocumentSequenceID', namespace: 'ns5'

            def self.domain_to_mapper(request)
              mapper = self.new
              mapper.DocumentBinary = DocumentBinary.domain_to_mapper(request.DocumentBinary) if request.DocumentBinary
              mapper.DocumentFileName = request.DocumentFileName if request.DocumentFileName
              mapper.DocumentSequenceID = request.DocumentSequenceID if request.DocumentSequenceID

              mapper
            end
          end
        end
      end
    end
  end
end