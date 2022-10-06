# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions.
          class PersonSsnIdentification
            include HappyMapper

            tag 'PersonSSNIdentification'
            namespace 'nc'

            element :identification_id, String, tag: "IdentificationID"
            element :identification_category_text, String, tag: "IdentificationCategoryText"

            def self.domain_to_mapper(ssn)
              mapper = self.new
              mapper.identification_id = ssn&.identification_id || ""
              mapper.identification_category_text = ssn.identification_category_text if ssn&.identification_category_text
              mapper
            end

            def to_hash
              {
                identification_id: identification_id
              }
            end
          end
        end
      end
    end
  end
end