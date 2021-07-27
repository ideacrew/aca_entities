# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Vlp
          module H92
            # Happymapper implementation for the root object of an
            # Request.
            class Ds2019DocumentId
              include HappyMapper
              register_namespace 'vlp', 'http://vlp.ee.sim.dsh.cms.hhs.gov'

              tag 'Ds2019DocumentID'
              namespace 'vlp'

              element :I94Number, String, tag: 'I94Number', namespace: "vlp"
              has_one :PassportCountry, PassportCountry
              element :SEVISID, String, tag: 'SEVISID', namespace: "vlp"
              element :DocExpirationDate, Date, tag: 'DocExpirationDate', namespace: "vlp"

              def self.domain_to_mapper(document)
                mapper = self.new
                mapper.I94Number = document.I94Number
                mapper.PassportCountry = PassportCountry.domain_to_mapper(document.PassportCountry)
                mapper.SEVISID = document.SEVISID
                mapper.DocExpirationDate = document.DocExpirationDate.strftime

                mapper
              end
            end
          end
        end
      end
    end
  end
end
