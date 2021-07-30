# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Vlp
          module H92
            # Happymapper implementation for the root object of an
            # Request.
            class PassportCountry
              include HappyMapper
              register_namespace 'vlp', 'http://vlp.ee.sim.dsh.cms.hhs.gov'

              tag 'PassportCountry'
              namespace 'vlp'

              element :PassportNumber, String, tag: 'PassportNumber', namespace: "vlp"
              element :CountryOfIssuance, String, tag: 'CountryOfIssuance', namespace: "vlp"

              def self.domain_to_mapper(passport)
                mapper = self.new
                mapper.PassportNumber = passport&.PassportNumber
                mapper.CountryOfIssuance = passport&.CountryOfIssuance

                mapper
              end
            end
          end
        end
      end
    end
  end
end
