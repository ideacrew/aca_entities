# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Vlp
          module H92
            # Happymapper implementation for the root object of an
            # Request.
            class CertOfCitDocumentId
              include HappyMapper
              register_namespace 'vlp', 'http://vlp.ee.sim.dsh.cms.hhs.gov'

              tag 'CertOfCitDocumentID'
              namespace 'vlp'

              element :AlienNumber, String, tag: 'AlienNumber', namespace: "vlp"
              element :CitizenshipNumber, String, tag: 'CitizenshipNumber', namespace: "vlp"

              def self.domain_to_mapper(document)
                mapper = self.new
                mapper.AlienNumber = document.AlienNumber
                mapper.CitizenshipNumber = document.CitizenshipNumber

                mapper
              end
            end
          end
        end
      end
    end
  end
end

