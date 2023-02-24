# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module H36
          # Happymapper implementation for the root object of an BatchMetadata.
          class BatchMetadata
            include HappyMapper

            register_namespace 'ns3', 'http://hix.cms.gov/0.1/hix-core'
            register_namespace 'ns4', 'http://birsrep.dsh.cms.gov/extension/1.0'

            tag 'BatchMetadata'
            namespace 'ns3'

            element :BatchID, String, tag: 'BatchID', namespace: 'ns3'
            element :BatchPartnerID, String, tag: 'BatchPartnerID', namespace: 'ns3'
            element :BatchAttachmentTotalQuantity, Float, tag: 'BatchAttachmentTotalQuantity', namespace: 'ns3'
            element :BatchCategoryCode, String, tag: 'BatchCategoryCode', namespace: 'ns4'
            element :BatchTransmissionQuantity, Float, tag: 'BatchTransmissionQuantity', namespace: 'ns3'

            def self.domain_to_mapper(request)
              mapper = self.new
              mapper.BatchID = request.BatchID if request.BatchID
              mapper.BatchPartnerID = request.BatchPartnerID if request.BatchPartnerID
              mapper.BatchAttachmentTotalQuantity = request.BatchAttachmentTotalQuantity if request.BatchAttachmentTotalQuantity
              mapper.BatchCategoryCode = request.BatchCategoryCode if request.BatchCategoryCode
              mapper.BatchTransmissionQuantity = request.BatchTransmissionQuantity if request.BatchTransmissionQuantity

              mapper
            end
          end
        end
      end
    end
  end
end