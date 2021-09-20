# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Rrv
          module H79
            # Happymapper implementation for the root object of an BatchHandlingServiceRequest.
            class BatchHandlingServiceRequest
              include HappyMapper
              register_namespace 'exch', 'http://rrvreq.dsh.cms.gov/exchange/1.0'
              register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'
              register_namespace 'ext', 'http://rrvreq.dsh.cms.gov/extension/1.0'

              tag 'BatchHandlingServiceRequest'
              namespace 'exch'

              has_one :BatchMetadata, BatchMetadata
              has_one :TransmissionMetadata, TransmissionMetadata
              has_one :ServiceSpecificData, ServiceSpecificData

              def self.domain_to_mapper(request)
                mapper = self.new
                mapper.BatchMetadata = BatchMetadata.domain_to_mapper(request.BatchMetadata)
                mapper.TransmissionMetadata = TransmissionMetadata.domain_to_mapper(request.TransmissionMetadata)
                mapper.ServiceSpecificData = ServiceSpecificData.domain_to_mapper(request.ServiceSpecificData)

                mapper
              end
            end
          end
        end
      end
    end
  end
end