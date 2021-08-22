# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module NonEsi
          module H31
            # Happymapper implementation for the root object of an Request.
            class VerifyNonEsiMecRequest
              include HappyMapper
              register_namespace 'vnem', 'http://vnem.ee.sim.dsh.cms.hhs.gov'

              tag 'VerifyNonESIMECRequest'
              namespace 'vnem'

              has_many :IndividualRequests, IndividualRequest

              def self.domain_to_mapper(request)
                mapper = self.new
                mapper.IndividualRequests = request.IndividualRequests.collect do |individual_request|
                  IndividualRequest.domain_to_mapper(individual_request)
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
