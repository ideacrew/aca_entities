# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions.
          class ApplicationIdentification
            include HappyMapper

            tag 'ApplicationIdentification'
            namespace 'hix-core'

            element :identification_id, String, tag: "IdentificationID", namespace: "nc"
            element :identification_category_text, String, tag: "IdentificationCategoryText", namespace: "nc"
            element :identification_jurisdiction, String, tag: "IdentificationJurisdictionISO3166Alpha3Code", namespace: "nc"

            def self.domain_to_mapper(id)
              mapper = self.new
              mapper.identification_id = id.identification_id
              mapper
            end

            def to_hash
              {
                identification_id: identification_id,
                identification_category_text: identification_category_text,
                identification_jurisdiction: identification_jurisdiction
              }
            end
          end
        end
      end
    end
  end
end