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
            register_namespace 'ext', 'http://ridp.dsh.cms.gov/extension/1.0'

            namespace 'ext'
            tag 'CurrentAddress'

            has_one :LocationAddress, LocationAddress

            def self.domain_to_mapper(current_address)
              mapper = self.new
              mapper.LocationAddress = LocationAddress.domain_to_mapper(current_address.LocationAddress)
              mapper
            end
          end
        end
      end
    end
  end
end
