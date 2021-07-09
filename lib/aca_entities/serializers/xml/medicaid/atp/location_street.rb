# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions. A data type for how to contact a person or an organization.
          class LocationStreet
            include HappyMapper
            register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'

            tag 'LocationStreet'
            namespace 'nc'

            element :street_full_text, String, tag: 'StreetFullText'

            def self.domain_to_mapper(location_street)
              mapper = self.new
              mapper.street_full_text = location_street.street_full_text
              mapper
            end

            def to_hash
              {
                street_full_text: street_full_text
              }
            end
          end
        end
      end
    end
  end
end