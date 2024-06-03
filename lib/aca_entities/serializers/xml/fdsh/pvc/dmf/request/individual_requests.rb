# frozen_string_literal: true

# require 'aca_entities/serializers/xml/fdsh/pvc/dmf/request/individual_request'

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Pvc
          module Dmf
            module Request
              # IndividualRequests class
              #
              # @!attribute [rw] IndividualRequests
              #   @return [Array<IndividualRequest>] an array of IndividualRequest objects
              class IndividualRequests
                include HappyMapper

                register_namespace 'exch', 'http://pvcdmfrqst.ee.sim.dsh.cms.hhs.gov/exchange/1.0'
                register_namespace 'ext', 'http://pvcdmfrqst.ee.sim.dsh.cms.hhs.gov/extension/1.0'
                register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'

                # XML tag for IndividualRequests
                tag 'Request'
                namespace 'exch'

                # XML mapping rule for IndividualRequests
                # @return [Array<IndividualRequest>]
                has_many :IndividualRequests, IndividualRequest

                # This method maps domain objects to mapper objects
                #
                # @param request [Object] the domain object
                # @return [IndividualRequests] the mapper object
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
end