# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module NonEsi
          module H31
            # Happymapper implementation for the root object of an Individual response set.
            class IndividualResponseSet
              include HappyMapper
              register_namespace 'vnem', 'http://vnem.ee.sim.dsh.cms.hhs.gov'

              tag 'IndividualResponseSet'
              namespace 'vnem'

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
