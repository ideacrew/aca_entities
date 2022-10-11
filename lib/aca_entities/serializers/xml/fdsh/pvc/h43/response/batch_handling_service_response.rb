# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Pvc
          module H43
            module Response
              # Happymapper implementation for the root object of an BatchHandlingServiceResponse.
              class BatchHandlingServiceResponse
                include HappyMapper
                register_namespace 'exch', 'http://pvchtorresp.dsh.cms.gov/exchange/1.0'
                register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'
                register_namespace 'ext', 'http://pvchtorresp.dsh.cms.gov/extension/1.0'

                tag 'BatchHandlingServiceRequest'
                namespace 'exch'

                has_one :BatchMetadata, BatchMetadata
                has_one :TransmissionMetadata, TransmissionMetadata
                has_one :ServiceSpecificData, ServiceSpecificData
                has_many :Attachments, ResponseAttachment

                def self.domain_to_mapper(response)
                  mapper = self.new
                  mapper.BatchMetadata = BatchMetadata.domain_to_mapper(response.BatchMetadata)
                  mapper.TransmissionMetadata = TransmissionMetadata.domain_to_mapper(response.TransmissionMetadata)
                  if response.ServiceSpecificData.present?
                    mapper.ServiceSpecificData = ServiceSpecificData.domain_to_mapper(response.ServiceSpecificData)
                  end
                  if response.Attachments.present?
                    mapper.Attachments = response.Attachments.collect do |attachment|
                      ResponseAttachment.domain_to_mapper(attachment)
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
  end
end