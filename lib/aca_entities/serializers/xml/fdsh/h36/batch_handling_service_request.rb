# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module H36
          # Happymapper implementation for the root object of an BatchHandlingServiceRequest.
          class BatchHandlingServiceRequest
            include HappyMapper
            register_namespace 'xmlns', 'http://birsrep.dsh.cms.gov/exchange/1.0'

            register_namespace 'ns3', 'http://hix.cms.gov/0.1/hix-core'
            register_namespace 'ns4', "http://birsrep.dsh.cms.gov/extension/1.0"
            register_namespace 'ns5', "http://niem.gov/niem/niem-core/2.0"

            tag 'BatchHandlingServiceRequest'

            has_one :BatchMetadata, BatchMetadata
            has_one :TransmissionMetadata, TransmissionMetadata
            has_one :ServiceSpecificData, ServiceSpecificData
            has_many :Attachments, Attachment

            def self.domain_to_mapper(request)
              mapper = self.new
              mapper.BatchMetadata = BatchMetadata.domain_to_mapper(request.BatchMetadata)
              mapper.TransmissionMetadata = TransmissionMetadata.domain_to_mapper(request.TransmissionMetadata)
              mapper.ServiceSpecificData = ServiceSpecificData.domain_to_mapper(request.ServiceSpecificData)

              if request.Attachments.present?
                mapper.Attachments = request.Attachments.collect do |attachment|
                  Attachment.domain_to_mapper(attachment)
                end
              end

              mapper
            end
          end
        end
      end
    end
  end
end