# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ssa
          module H3
            # Happymapper implementation for the root object of an
            # response.
            class FacilityLocation
              include HappyMapper
              register_namespace 'extn', 'http://extn.ssac.ee.sim.dsh.cms.hhs.gov'
              register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'

              tag 'FacilityLocation'
              namespace 'extn'

              element :LocationStreet, String, tag: 'LocationStreet', namespace: "extn"
              element :LocationCityName, String, tag: 'LocationCityName', namespace: "extn"
              element :LocationStateUSPostalServiceCode, String, tag: 'LocationStateUSPostalServiceCode', namespace: "nc"
              element :LocationPostalCode, String, tag: 'LocationPostalCode', namespace: "extn"
              element :LocationPostalExtensionCode, String, tag: 'LocationPostalExtensionCode', namespace: "extn"

              def self.domain_to_mapper(initial_response)
                mapper = self.new

                mapper.LocationStreet = initial_response.LocationStreet
                mapper.LocationCityName = initial_response.LocationCityName
                mapper.LocationStateUSPostalServiceCode = initial_response.LocationStateUSPostalServiceCode
                mapper.LocationPostalCode = initial_response.LocationPostalCode
                mapper.LocationPostalExtensionCode = initial_response.LocationPostalExtensionCode

                mapper
              end
            end
          end
        end
      end
    end
  end
end