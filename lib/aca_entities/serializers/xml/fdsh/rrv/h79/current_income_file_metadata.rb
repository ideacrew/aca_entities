# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Rrv
          module H79
            # Happymapper implementation for the root object of an TransmissionMetadata.
            class CurrentIncomeFileMetadata
              include HappyMapper
              register_namespace 'ext', 'http://rrvreq.dsh.cms.gov/extension/1.0'

              tag 'CurrentIncomeFileMetadata'
              namespace 'ext'

              element :CurrentIncomeDocumentAttachmentQuantity, Float, tag: 'CurrentIncomeDocumentAttachmentQuantity', namespace: 'ext'
              has_one :Attachment, RequestAttachment

              def self.domain_to_mapper(request)
                mapper = self.new
                mapper.CurrentIncomeDocumentAttachmentQuantity = request.CurrentIncomeDocumentAttachmentQuantity
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