# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions.
          class SsfPrimaryContact
            include HappyMapper

            tag 'SSFPrimaryContact'
            namespace 'hix-ee'

            has_one :role_reference, RoleOfPersonReference
            element :contact_preference, String, tag: "SSFPrimaryContactPreferenceCode", namespace: "hix-ee"

            def self.domain_to_mapper(insurance_application)
              mapper = self.new
              mapper.role_reference = RoleOfPersonReference.domain_to_mapper(insurance_application)
              mapper.contact_preference = "Email"
              mapper
            end

            def to_hash
              {
                role_reference: role_reference.to_hash,
                contact_preference: contact_preference
              }
            end
          end
        end
      end
    end
  end
end