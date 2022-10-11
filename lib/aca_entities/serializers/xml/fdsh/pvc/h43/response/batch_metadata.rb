# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Pvc
          module H43
            module Response
              # Happymapper implementation for the root object of an BatchMetadata.
              class BatchMetadata
                include HappyMapper
                register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'
                register_namespace 'ext', 'http://pvchtorresp.dsh.cms.gov/extension/1.0'

                tag 'BatchMetadata'
                namespace 'hix-core'

                element :BatchID, String, tag: 'BatchID', namespace: 'hix-core'
                element :BatchPartnerID, String, tag: 'BatchPartnerID', namespace: 'hix-core'
                element :BatchAttachmentTotalQuantity, Float, tag: 'BatchAttachmentTotalQuantity', namespace: 'hix-core'
                element :BatchCategoryCode, String, tag: 'BatchCategoryCode', namespace: 'ext'
                element :BatchTransmissionQuantity, Float, tag: 'BatchTransmissionQuantity', namespace: 'hix-core'

                def self.domain_to_mapper(request)
                  mapper = self.new
                  mapper.BatchID = request.BatchID if request.BatchID.present?
                  mapper.BatchPartnerID = request.BatchPartnerID if request.BatchPartnerID.present?
                  mapper.BatchAttachmentTotalQuantity = request.BatchAttachmentTotalQuantity if request.BatchAttachmentTotalQuantity.present?
                  mapper.BatchCategoryCode = request.BatchCategoryCode if request.BatchCategoryCode.present?
                  mapper.BatchTransmissionQuantity = request.BatchTransmissionQuantity if request.BatchTransmissionQuantity.present?

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