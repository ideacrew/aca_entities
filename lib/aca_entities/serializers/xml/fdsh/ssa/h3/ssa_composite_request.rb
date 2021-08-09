# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ssa
          module H3
            # Happymapper implementation for the root object of an
            # Request.
            class SSACompositeRequest
              include HappyMapper
              register_namespace 'exch', 'http://ssac.ee.sim.dsh.cms.hhs.gov'

              tag 'SSACompositeRequest'
              namespace 'exch'

              has_many :SSACompositeIndividualRequests, SSACompositeIndividualRequest

              def self.domain_to_mapper(initial_request)
                mapper = self.new
                mapper.SSACompositeIndividualRequests = initial_request.SSACompositeIndividualRequests.collect do |request_set|
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