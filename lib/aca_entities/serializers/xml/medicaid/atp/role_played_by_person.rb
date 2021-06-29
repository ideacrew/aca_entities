# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions. A human being.
          class RolePlayedByPerson
            include HappyMapper

            tag 'RolePlayedByPerson'
            namespace 'hix-ee'

            has_one :person_name, PersonName
            has_one :birth_date, PersonBirthDate
            element :sex, String, tag: "PersonSexText", namespace: "nc"

            def self.domain_to_mapper(_role)
              self.new
            end

            def to_hash
              {
                person_name: person_name&.to_hash,
                sex: sex,
                birth_date: birth_date&.to_hash
              }
            end
          end
        end
      end
    end
  end
end