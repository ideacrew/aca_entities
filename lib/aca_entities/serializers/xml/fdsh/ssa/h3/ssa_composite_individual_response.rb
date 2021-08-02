# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ssa
          module H3
            # Happymapper implementation for the root object of an
            # Request.
            class SSACompositeIndividualResponse
              include HappyMapper
              register_namespace 'extn', 'http://extn.ssac.ee.sim.dsh.cms.hhs.gov'

              tag 'SSACompositeIndividualResponse'
              namespace 'extn'

              has_one :ResponseMetadata, ResponseMetadata
              attribute :PersonSSNIdentification, String, tag: 'PersonSSNIdentification', namespace: "extn"
              has_one :SSAResponse, SSAResponse

              def self.domain_to_mapper(initial_request)
                mapper = self.new

                mapper.ResponseMetadata = ResponseMetadata.domain_to_mapper(initial_request.ResponseMetadata)
                mapper.PersonSSNIdentification = initial_request.PersonSSNIdentification
                mapper.SSAResponse = SSAResponse.domain_to_mapper(initial_request.SSAResponse)

                mapper
              end
            end
          end
        end
      end
    end
  end
end