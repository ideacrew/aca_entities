# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions.
          class Person
            include HappyMapper
            register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'
            register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'
            register_namespace 'niem-s', 'http://niem.gov/niem/structures/2.0'

            tag 'Person'
            namespace 'hix-core'

            has_one :person_name, PersonName

            attribute :id, String, namespace: "niem-s"

            element :us_citizen_indicator, Boolean, tag: "PersonUSCitizenIndicator", namespace: "nc"
            element :living_indicator, Boolean, tag: "PersonLivingIndicator", namespace: "nc"
            element :ssn, String, tag: "PersonSSNIdentification/ns2:IdentificationID", namespace: "nc"
            element :sex, String, tag: "PersonSexText", namespace: "nc"
            element :race, String, tag: "PersonRaceText", namespace: "nc"
            element :ethnicity, String, tag: "PersonEthnicityText", namespace: "nc"

            has_one :birth_date, PersonBirthDate
            has_one :augementation, PersonAugmentation

            def self.domain_to_mapper(applicant)
              mapper = self.new
              mapper.person_name = PersonName.domain_to_mapper(applicant)
              mapper
            end

            def to_hash
              {
                person_name: person_name&.to_hash,
                us_citizen_indicator: us_citizen_indicator,
                living_indicator: living_indicator,
                ssn: ssn,
                sex: sex,
                race: race,
                ethnicity: ethnicity,
                birth_date: birth_date&.to_hash,
                augementation: augementation&.to_hash
              }
            end
          end
        end
      end
    end
  end
end