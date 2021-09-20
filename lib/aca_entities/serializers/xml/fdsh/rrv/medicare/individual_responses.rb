# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Rrv
          module Medicare
            # Happymapper implementation for the root object of an Request.
            class IndividualResponses
              include HappyMapper

              tag 'IndividualResponses'

              has_many :IndividualResponses, IndividualResponse

              def self.domain_to_mapper(response)
                mapper = self.new
                mapper.IndividualResponses = response.IndividualResponses.collect do |individual_response|
                  IndividualResponse.domain_to_mapper(individual_response)
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
