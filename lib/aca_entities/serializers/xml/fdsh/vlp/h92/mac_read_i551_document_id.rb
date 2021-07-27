# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Vlp
          module H92
            # Happymapper implementation for the root object of an MacReadI551DocumentId.
            class MacReadI551DocumentId
              include HappyMapper
              register_namespace 'vlp', 'http://vlp.ee.sim.dsh.cms.hhs.gov'

              tag 'MacReadI551DocumentID'
              namespace 'vlp'

              element :AlienNumber, String, tag: 'AlienNumber', namespace: "vlp"
              element :VisaNumber, String, tag: 'VisaNumber', namespace: "vlp"
              element :PassportNumber, String, tag: 'PassportNumber', namespace: "vlp"
              element :CountryOfIssuance, String, tag: 'CountryOfIssuance', namespace: "vlp"
              element :DocExpirationDate, Date, tag: 'DocExpirationDate', namespace: "vlp"

              def self.domain_to_mapper(document)
                mapper = self.new
                mapper.AlienNumber = document.AlienNumber
                mapper.VisaNumber = document.VisaNumber
                mapper.PassportNumber = document.PassportNumber
                mapper.CountryOfIssuance = document.CountryOfIssuance
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
