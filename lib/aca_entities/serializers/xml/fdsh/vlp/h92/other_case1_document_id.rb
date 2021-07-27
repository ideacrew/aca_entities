# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Vlp
          module H92
            # Happymapper implementation for the root object of an
            # Request.
            class OtherCase1DocumentId
              include HappyMapper
              register_namespace 'vlp', 'http://vlp.ee.sim.dsh.cms.hhs.gov'

              tag 'OtherCase1DocumentID'
              namespace 'vlp'

              element :AlienNumber, String, tag: 'AlienNumber', namespace: "vlp"
              has_one :PassportCountry, PassportCountry
              element :DocExpirationDate, Date, tag: 'DocExpirationDate', namespace: "vlp"
              element :DocDescReq, String, tag: 'DocDescReq', namespace: "vlp"

              def self.domain_to_mapper(document)
                mapper = self.new
                mapper.AlienNumber = document.AlienNumber
                mapper.PassportCountry = PassportCountry.domain_to_mapper(document.PassportCountry)
                mapper.DocExpirationDate = document.DocExpirationDate.strftime
                mapper.DocDescReq = document.DocDescReq

                mapper
              end
            end
          end
        end
      end
    end
  end
end
