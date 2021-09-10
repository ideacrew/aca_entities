# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Rrv
          module Medicare
            # Happymapper implementation for the root object of an Request.
            class IndividualRequests
              include HappyMapper

              tag 'IndividualRequests'

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
