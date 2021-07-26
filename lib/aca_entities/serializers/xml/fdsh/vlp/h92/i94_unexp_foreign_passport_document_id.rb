# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Vlp
          module H92
            # Happymapper implementation for the root object of an
            # Request.
            class I94UnexpForeignPassportDocumentId
              include HappyMapper
              register_namespace 'vlp', 'http://vlp.ee.sim.dsh.cms.hhs.gov'

              tag 'I94UnexpForeignPassportDocumentID'
              namespace 'vlp'

              element :I94Number, String, tag: 'I94Number', namespace: "vlp"
              element :VisaNumber, String, tag: 'VisaNumber', namespace: "vlp"
              element :PassportNumber, String, tag: 'PassportNumber', namespace: "vlp"
              element :CountryOfIssuance, String, tag: 'CountryOfIssuance', namespace: "vlp"
              element :SEVISID, String, tag: 'SEVISID', namespace: "vlp"
              element :DocExpirationDate, Date, tag: 'DocExpirationDate', namespace: "vlp"

              def self.domain_to_mapper(document)
                mapper = self.new
                mapper.I94Number = document.I94Number
                mapper.VisaNumber = document.VisaNumber
                mapper.PassportNumber = document.PassportNumber
                mapper.CountryOfIssuance = document.CountryOfIssuance
                mapper.SEVISID = document.SEVISID
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
