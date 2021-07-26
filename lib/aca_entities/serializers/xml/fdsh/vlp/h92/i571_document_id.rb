# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Vlp
          module H92
            # Happymapper implementation for the root object of an
            # Request.
            class I571DocumentId
              include HappyMapper
              register_namespace 'vlp', 'http://vlp.ee.sim.dsh.cms.hhs.gov'

              tag 'I571DocumentID'
              namespace 'vlp'

              element :AlienNumber, String, tag: 'AlienNumber', namespace: "vlp"
              element :DocExpirationDate, Date, tag: 'DocExpirationDate', namespace: "vlp"

              def self.domain_to_mapper(document)
                mapper = self.new
                mapper.AlienNumber = document.AlienNumber
                mapper.DocExpirationDate = document.DocExpirationDate

                mapper
              end
            end
          end
        end
      end
    end
  end
end

