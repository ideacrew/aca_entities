# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions. A data type for how to contact a person or an organization.
          class Street
            include HappyMapper

            tag 'Street'
            namespace 'nc'

            has_one :street_full_text, String, tag: 'StreetFullText'

            def self.domain_to_mapper(_contact_info)
              self.new
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