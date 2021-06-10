# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ridp
          # Happymapper implementation for the root object of an
          # LocationAddress.
          class LocationAddress
            include HappyMapper
            register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'

            namespace 'nc'
            tag 'LocationAddress'

            has_one :StructuredAddress, StructuredAddress

            def self.domain_to_mapper(location_address)
              mapper = self.new
              mapper.StructuredAddress = StructuredAddress.domain_to_mapper(location_address)
              mapper
            end
          end
        end
      end
    end
  end
end
