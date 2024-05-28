# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions.
          class Person
            include HappyMapper

            tag 'Person'
            namespace 'hix-core'

            attribute :id, String, namespace: "niem-s"
            has_one :age_measure, PersonAgeMeasure
            has_one :birth_date, PersonBirthDate
            has_many :ethnicities, String, tag: "PersonEthnicityText", namespace: "nc"
            # has_many :ethnicities, PersonEthnicityText
            element :living_indicator, Boolean, tag: "PersonLivingIndicator", namespace: "nc"
            has_one :person_name, PersonName
            element :race, String, tag: "PersonRaceText", namespace: "nc"
            element :sex, String, tag: "PersonSexText", namespace: "nc"
            has_one :ssn_identification, PersonSsnIdentification
            element :us_citizen_indicator, Boolean, tag: "PersonUSCitizenIndicator", namespace: "nc"
            has_one :tribal_augmentation, TribalAugmentation
            has_one :person_augmentation, PersonAugmentation

            def self.domain_to_mapper(person)
              mapper = self.new
              mapper.id = person.id
              mapper.age_measure = PersonAgeMeasure.domain_to_mapper(person.age_measure)
              mapper.birth_date = PersonBirthDate.domain_to_mapper(person.birth_date)
              if person&.ethnicities
                mapper.ethnicities = person&.ethnicities&.map { |v| PersonEthnicityText.domain_to_mapper(v) if v.present? }
              end
              mapper.person_name = PersonName.domain_to_mapper(person.person_name)
              mapper.race = person.race
              mapper.sex = person.sex
              if person.ssn_identification&.identification_id.present?
                mapper.ssn_identification = PersonSsnIdentification.domain_to_mapper(person.ssn_identification)
              end
              mapper.us_citizen_indicator = person.us_citizen_indicator
              mapper.living_indicator = person.living_indicator
              mapper.person_augmentation = PersonAugmentation.domain_to_mapper(person.person_augmentation)
              mapper.tribal_augmentation = TribalAugmentation.domain_to_mapper(person.tribal_augmentation)
              mapper
            end

            def to_hash
              {
                id: id,
                age_measure: age_measure&.to_hash,
                person_name: person_name&.to_hash,
                us_citizen_indicator: us_citizen_indicator,
                living_indicator: living_indicator,
                ssn_identification: ssn_identification&.to_hash,
                sex: sex,
                race: race,
                ethnicities: ethnicities,
                birth_date: birth_date&.to_hash,
                tribal_augmentation: tribal_augmentation&.to_hash,
                augementation: person_augmentation&.to_hash # update the name in family transform
              }
            end
          end
        end
      end
    end
  end
end