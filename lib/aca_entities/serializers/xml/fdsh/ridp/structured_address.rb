# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ridp
          # Happymapper implementation for the root object of an
          # StructuredAddress.
          class StructuredAddress
            include HappyMapper
            register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'

            namespace 'nc'
            tag 'StructuredAddress'

            has_one :LocationStreet, LocationStreet
            element :LocationCityName, String, tag: 'LocationCityName'
            element :LocationStateUSPostalServiceCode, String, tag: 'LocationStateUSPostalServiceCode'
            element :LocationPostalCode, String, tag: 'LocationPostalCode'
            element :LocationPostalExtensionCode, String, tag: 'LocationPostalExtensionCode'

            def self.domain_to_mapper(structured_address)
              mapper = self.new
              mapper.LocationStreet = LocationStreet.domain_to_mapper(structured_address.LocationStreet)
              mapper.LocationCityName = structured_address.LocationCityName
              mapper.LocationStateUSPostalServiceCode = structured_address.LocationStateUSPostalServiceCode
              mapper.LocationPostalCode = structured_address.LocationPostalCode
              mapper.LocationPostalExtensionCode = structured_address.LocationPostalExtensionCode
              mapper
            end
          end
        end
      end
    end
  end
end
