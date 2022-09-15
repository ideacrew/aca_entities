# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Vlp
          module H92
            # Happymapper implementation for the root object of an
            # Request.
            class I94DocumentId
              include HappyMapper
              register_namespace 'vlp', 'http://vlp.ee.sim.dsh.cms.hhs.gov'

              tag 'I94DocumentID'
              namespace 'vlp'

              element :I94Number, String, tag: 'I94Number', namespace: "vlp"
              element :SEVISID, String, tag: 'SEVISID', namespace: "vlp"
              element :DocExpirationDate, Date, tag: 'DocExpirationDate', namespace: "vlp"

              def self.domain_to_mapper(document)
                mapper = self.new
                mapper.I94Number = document.I94Number
                mapper.SEVISID = document.SEVISID
                mapper.DocExpirationDate = document.DocExpirationDate&.strftime

                mapper
              end
            end
          end
        end
      end
    end
  end
end
