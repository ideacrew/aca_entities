# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions. A human being.
          class RolePlayedByPerson
            include HappyMapper
            register_namespace 'hix-ee', 'http://hix.cms.gov/0.1/hix-ee'
            register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'

            tag 'RolePlayedByPerson'
            namespace 'hix-ee'

            has_one :person_name, PersonName
            has_one :birth_date, PersonBirthDate
            element :sex, String, tag: "PersonSexText", namespace: "nc"

            def self.domain_to_mapper(_role)
              self.new
            end
          end
        end
      end
    end
  end
end