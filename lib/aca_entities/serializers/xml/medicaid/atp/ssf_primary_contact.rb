# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          class SsfPrimaryContact
            include HappyMapper
            register_namespace 'hix-ee', 'http://hix.cms.gov/0.1/hix-ee'

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
          end
        end
      end
    end
  end
end