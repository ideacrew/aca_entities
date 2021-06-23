# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions.
          class ApplicationIdentification
            include HappyMapper
            register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'
            register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'

            tag 'ApplicationIdentification'
            namespace 'hix-core'

            element :identification_id, String, tag: "IdentificationID", namespace: "nc"
            element :identification_category_text, String, tag: "IdentificationCategoryText", namespace: "nc"
            element :identification_jurisdication, String, tag: "IdentificationJurisdictionISO3166Alpha3Code", namespace: "nc"

            def self.domain_to_mapper(id)
              mapper = self.new
              mapper.identification_id = id
              mapper
            end

            def to_hash
              {
                identification_id: identification_id,
                identification_category_text: identification_category_text,
                identification_jurisdication: identification_jurisdication
              }
            end
          end
        end
      end
    end
  end
end