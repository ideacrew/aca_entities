# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Vlp
          module Rx1424
            # Happymapper implementation for the root object of an
            # Request.
            class CloseCaseResponse
              include HappyMapper
              register_namespace 'vlpcc', 'http://vclpcc.ee.sim.dsh.cms.hhs.gov'

              tag 'CloseCaseResponse'
              namespace 'vlpcc'

              has_one :ResponseMetadata, ResponseMetadata
              has_one :ArrayOfErrorResponseMetadata, ArrayOfErrorResponseMetadata
              has_one :CloseCaseResponseSet, CloseCaseResponseSet

              def self.domain_to_mapper(response)
                mapper = self.new
                mapper.ResponseMetadata = ResponseMetadata.domain_to_mapper(response.ResponseMetadata)
                mapper.ArrayOfErrorResponseMetadata = ArrayOfErrorResponseMetadata.domain_to_mapper(response.ArrayOfErrorResponseMetadata)
                mapper.CloseCaseResponseSet = CloseCaseResponseSet.domain_to_mapper(response.CloseCaseResponseSet)

                mapper
              end
            end
          end
        end
      end
    end
  end
end
