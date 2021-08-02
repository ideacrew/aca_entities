# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ssa
          module H3
            # Happymapper implementation for the root object of an
            # Request.
            class SsaCompositeRequest
              include HappyMapper
              register_namespace 'ssac', 'http://ssac.ee.sim.dsh.cms.hhs.gov'

              tag 'SSACompositeRequest'
              namespace 'ssac'

              has_many :SsaCompositeIndividualRequests, SsaCompositeIndividualRequest

              def self.domain_to_mapper(initial_request)
                mapper = self.new
                mapper.SsaCompositeIndividualRequests = initial_request.SsaCompositeIndividualRequests.collect do |request_set|
                  SsaCompositeIndividualRequest.domain_to_mapper(request_set)
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