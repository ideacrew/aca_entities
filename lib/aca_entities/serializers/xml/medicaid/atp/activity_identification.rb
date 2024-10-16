# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions.
          class ActivityIdentification
            include HappyMapper

            tag 'ActivityIdentification'
            namespace 'nc'

            # A value that identifies something.
            element :identification_id, String, tag: "IdentificationID", namespace: "nc"

            # A kind of identification.
            element :identification_category_text, String, tag: "IdentificationCategoryText", namespace: "nc"

            # An area, region, or unit in which a unique identification is issued.
            element :identification_jurisdiction, String, tag: "IdentificationJurisdictionISO3166Alpha3Code", namespace: "nc"

            def self.domain_to_mapper(identification)
              mapper = self.new
              mapper.identification_id = identification.identification_id
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