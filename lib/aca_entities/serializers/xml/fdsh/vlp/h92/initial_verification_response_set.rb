# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Vlp
          module H92
            # Happymapper implementation for the root object of an
            # response.
            class InitialVerificationResponseSet
              include HappyMapper
              register_namespace 'vlp', 'http://vlp.ee.sim.dsh.cms.hhs.gov'

              tag 'InitialVerificationResponseSet'
              namespace 'vlp'

              has_many :InitialVerificationIndividualResponses, InitialVerificationIndividualResponse

              def self.domain_to_mapper(response_set)
                mapper = self.new
                mapper.InitialVerificationIndividualResponses = response_set.InitialVerificationIndividualResponses.collect do |individual_response|
                  InitialVerificationIndividualResponse.domain_to_mapper(individual_response)
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
