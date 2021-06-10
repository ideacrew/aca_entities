# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ridp
          # Happymapper implementation for the root object of an
          # CurrentAddress.
          class CurrentAddress
            include HappyMapper
            register_namespace 'ex', 'http://ridp.dsh.cms.gov/exchange/1.0'
            register_namespace 'ext', 'http://ridp.dsh.cms.gov/extension/1.0'
            register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'


            tag 'ext::CurrentAddress/nc:LocationAddress/nc:StructuredAddress'
            namespace 'nc'

            element :StreetName, String, namespace: 'nc:LocationStreet', tag: 'StreetName'
            element :LocationCityName, String, tag: 'LocationCityName'
            element :LocationStateUSPostalServiceCode, String, tag: 'LocationStateUSPostalServiceCode'
            element :LocationPostalCode, String, tag: 'LocationPostalCode'
            element :LocationPostalExtensionCode, String, tag: 'LocationPostalExtensionCode'

            def self.domain_to_mapper(current_address)
              mapper = self.new
              mapper.StreetName = current_address.StreetName
              mapper.LocationCityName = current_address.LocationCityName
              mapper.LocationStateUSPostalServiceCode = current_address.LocationStateUSPostalServiceCode
              mapper.LocationPostalCode = current_address.LocationPostalCode
              mapper.LocationPostalExtensionCode = current_address.LocationPostalExtensionCode
              mapper
            end
          end
        end
      end
    end
  end
end