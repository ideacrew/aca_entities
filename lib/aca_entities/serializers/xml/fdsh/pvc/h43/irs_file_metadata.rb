# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Pvc
          module H43
            # Happymapper implementation for the root object of an TransmissionMetadata.
            class IrsFileMetadata
              include HappyMapper
              register_namespace 'ext', 'http://rrvreq.dsh.cms.gov/extension/1.0'

              tag 'IRSFileMetadata'
              namespace 'ext'

              element :IRSDocumentAttachmentQuantity, Float, tag: 'IRSDocumentAttachmentQuantity', namespace: 'ext'
              has_many :Attachments, RequestAttachment

              def self.domain_to_mapper(request)
                mapper = self.new
                mapper.IRSDocumentAttachmentQuantity = request.IRSDocumentAttachmentQuantity
                mapper.Attachments = request.Attachments.collect do |attachment|
                  RequestAttachment.domain_to_mapper(attachment)
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