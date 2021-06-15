# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions. A data type for how to contact a person or an organization.
          class Street
            include HappyMapper
            register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'

            tag 'Street'
            namespace 'nc'

            has_one :street_full_text, Street, tag: 'StreetFullText'

            def self.domain_to_mapper(contact_info)
              mapper = self.new
              mapper
            end
          end
        end
      end
    end
  end
end