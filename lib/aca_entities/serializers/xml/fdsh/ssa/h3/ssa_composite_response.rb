# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ssa
          module H3
            # Happymapper implementation for the root object of an
            # Request.
            class SSACompositeResponse
              include HappyMapper
              register_namespace 'exch', 'http://ssac.ee.sim.dsh.cms.hhs.gov'

              tag 'SSACompositeResponse'
              namespace 'exch'

              has_one :ResponseMetadata, ResponseMetadata
              has_many :SSACompositeIndividualResponses, SSACompositeIndividualResponse

              def self.domain_to_mapper(initial_request)
                mapper = self.new
                mapper.ResponseMetadata = ResponseMetadata.domain_to_mapper(initial_request.ResponseMetadata)
                mapper.SSACompositeIndividualResponses = initial_request.SSACompositeIndividualResponses.collect do |request_set|
                  SSACompositeIndividualRequest.domain_to_mapper(request_set)
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