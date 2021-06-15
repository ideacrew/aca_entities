# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions.
          class ActivityIdentification
            include HappyMapper
            register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'

            tag 'ActivityIdentification'
            namespace 'nc'

            element :identification_id, String, tag: "IdentificationID", namespace: "nc"
            element :identification_category_text, String, tag: "IdentificationCategoryText", namespace: "nc"
            element :identification_jurisdication, String, tag: "IdentificationJurisdictionISO3166Alpha3Code", namespace: "nc"

            def self.domain_to_mapper(identification)
              mapper = self.new
              mapper.identification_id = identification
              mapper
            end
          end
        end
      end
    end
  end
end