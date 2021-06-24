# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions. A data type for how to contact a person or an organization.
          class FullTelephone
            include HappyMapper

            tag 'FullTelephone'
            namespace 'nc'

            element :telephone_number_full_id, String, tag: "TelephoneNumberFullID", namespace: "nc"
            element :telephone_suffix_id, String, tag: "TelephoneSuffixID", namespace: "nc"

            def self.domain_to_mapper(contact_info)
              mapper = self.new
              mapper
            end

            def to_hash
              {
                telephone_number_full_id: telephone_number_full_id,
                telephone_suffix_id: telephone_suffix_id
              }
            end
          end
        end
      end
    end
  end
end