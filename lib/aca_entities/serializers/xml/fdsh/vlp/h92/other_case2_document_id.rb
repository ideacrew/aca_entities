# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Vlp
          module H92
            # Happymapper implementation for the root object of an
            # Request.
            class OtherCase2DocumentId
              include HappyMapper
              register_namespace 'vlp', 'http://vlp.ee.sim.dsh.cms.hhs.gov'

              tag 'OtherCase2DocumentID'
              namespace 'vlp'

              element :I94Number, String, tag: 'I94Number', namespace: "vlp"
              has_one :PassportCountry, PassportCountry
              element :SEVISID, String, tag: 'SEVISID', namespace: "vlp"
              element :DocExpirationDate, Date, tag: 'DocExpirationDate', namespace: "vlp"
              element :DocDescReq, String, tag: 'DocDescReq', namespace: "vlp"

              def self.domain_to_mapper(document)
                mapper = self.new
                mapper.I94Number = document.I94Number
                mapper.PassportCountry = PassportCountry.domain_to_mapper(document.PassportCountry) if document.PassportCountry.present?
                mapper.SEVISID = document.SEVISID
                mapper.DocExpirationDate = document.DocExpirationDate&.strftime
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
