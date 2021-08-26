# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module NonEsi
          module H31
            # Happymapper implementation for the root object of an response.
            class VerifyNonEsiMecResponse
              include HappyMapper
              register_namespace 'vnem', 'http://vnem.ee.sim.dsh.cms.hhs.gov'

              tag 'VerifyNonESIMECResponse'
              namespace 'vnem'

              has_one :IndividualResponseSet, IndividualResponseSet
              has_one :ResponseMetadata, ResponseMetadata, tag: 'vnem', :xpath => 'VerifyNonESIMECResponse'

              def self.domain_to_mapper(response)
                mapper = self.new
                mapper.IndividualResponseSet = response.IndividualResponseSet
                mapper.ResponseMetadata = response.ResponseMetadata if response.ResponseMetadata

                mapper
              end
            end
          end
        end
      end
    end
  end
end
