# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ridp
          # Happymapper implementation for the root object of an
          # LocationStreet.
          class LocationStreet
            include HappyMapper
            register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'

            namespace 'nc'
            tag 'LocationStreet'

            element :StreetName, String, tag: 'StreetName'

            def self.domain_to_mapper(_location_address)
              self.new
            end
          end
        end
      end
    end
  end
end
