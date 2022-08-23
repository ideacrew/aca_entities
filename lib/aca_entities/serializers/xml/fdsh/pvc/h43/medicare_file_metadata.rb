# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Pvc
          module H43
            # Happymapper implementation for the root object of an TransmissionMetadata.
            class MedicareFileMetadata
              include HappyMapper
              register_namespace 'ext', 'http://rrvreq.dsh.cms.gov/extension/1.0'

              tag 'MedicareFileMetadata'
              namespace 'ext'

              element :MedicareDocumentAttachmentQuantity, Float, tag: 'MedicareDocumentAttachmentQuantity', namespace: 'ext'
              has_one :Attachment, RequestAttachment

              def self.domain_to_mapper(request)
                mapper = self.new
                mapper.MedicareDocumentAttachmentQuantity = request.MedicareDocumentAttachmentQuantity
                mapper.Attachment = RequestAttachment.domain_to_mapper(request.Attachment)

                mapper
              end
            end
          end
        end
      end
    end
  end
end