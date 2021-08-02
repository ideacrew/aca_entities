# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Vlp
          module H92
            # Happymapper implementation for the root object of an
            # response.
            class InitialVerificationIndividualResponse
              include HappyMapper
              register_namespace 'vlp', 'http://vlp.ee.sim.dsh.cms.hhs.gov'

              tag 'InitialVerificationIndividualResponse'
              namespace 'vlp'

              has_one :ResponseMetadata, ResponseMetadata
              has_one :ArrayOfErrorResponseMetadata, ArrayOfErrorResponseMetadata
              element :LawfulPresenceVerifiedCode, String, tag: 'LawfulPresenceVerifiedCode', namespace: "vlp"
              has_one :InitialVerificationIndividualResponseSet, InitialVerificationIndividualResponseSet

              def self.domain_to_mapper(initial_response_set)
                mapper = self.new
                mapper.ResponseMetadata = initial_response_set.ResponseMetadata
                mapper.ArrayOfErrorResponseMetadata = initial_response_set.ArrayOfErrorResponseMetadata
                mapper.LawfulPresenceVerifiedCode = initial_response_set.LawfulPresenceVerifiedCode
                mapper.InitialVerificationIndividualResponseSet = initial_response_set.InitialVerificationIndividualResponseSet

                mapper
              end
            end
          end
        end
      end
    end
  end
end
