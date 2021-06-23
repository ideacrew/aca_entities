# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions. A data type for how to contact a person or an organization.
          class StructuredAddress
            include HappyMapper
            register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'

            tag 'StructuredAddress'
            namespace 'nc'

            has_one :location_street, Street, tag: 'LocationStreet'
            element :address_secondary_unit_text, String, tag: 'AddressSecondaryUnitText'
            element :location_city_name, String, tag: 'LocationCityName'
            element :location_county_name, String, tag: 'LocationCountyName'
            element :location_county_code, String, tag: 'LocationCountyCode'
            element :location_state_us_postal_service_code, String, tag: 'LocationStateUSPostalServiceCode'
            element :location_postal_code, String, tag: 'LocationPostalCode'

            def self.domain_to_mapper(contact_info)
              mapper = self.new
              mapper
            end

            def to_hash
              {
                location_street: location_street.to_hash,
                address_secondary_unit_text: address_secondary_unit_text,
                location_city_name: location_city_name,
                location_county_name: location_county_name,
                location_county_code: location_county_code,
                location_state_us_postal_service_code: location_state_us_postal_service_code,
                location_postal_code: location_postal_code
              }
            end
          end
        end
      end
    end
  end
end