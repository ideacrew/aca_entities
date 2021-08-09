# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Vlp
          module H92
            # Happymapper implementation for the root object of an
            # response.
            class InitialVerificationResponse
              include HappyMapper
              register_namespace 'vlp', 'http://vlp.ee.sim.dsh.cms.hhs.gov'

              tag 'InitialVerificationResponse'
              namespace 'vlp'

              has_one :ResponseMetadata, ResponseMetadata
              has_one :InitialVerificationResponseSet, InitialVerificationResponseSet

              def self.domain_to_mapper(initial_response)
                mapper = self.new
                mapper.ResponseMetadata = initial_response.ResponseMetadata
                mapper.InitialVerificationResponseSet = initial_response.InitialVerificationResponseSet

                mapper
              end
            end
          end
        end
      end
    end
  end
end
