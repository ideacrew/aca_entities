# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Pvc
          module Dmf
            # IndividualRequests class
            #
            # @!attribute [rw] IndividualRequests
            #   @return [Array<IndividualRequest>] an array of IndividualRequest objects
            class IndividualRequests
              include HappyMapper

              # XML tag for IndividualRequests
              tag 'IndividualRequests'

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