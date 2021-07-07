# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A data type that supplements an nc:Person with health insurance specific information.
          class PersonAugmentation
            include HappyMapper

            tag 'PersonAugmentation'
            namespace 'hix-core'

            element :us_naturalized_citizen_indicator, Boolean, tag: "USNaturalizedCitizenIndicator", namespace: "hix-core"
            element :us_veteran_indicator, Boolean, tag: "PersonUSVeteranIndicator", namespace: "hix-core"
            element :married_indicator, Boolean, tag: 'PersonMarriedIndicator', namespace: "hix-core"
            has_one :pregnancy_status, PersonPregnancyStatus
            has_one :medicaid_id, PersonMedicaidIdentification
            has_one :chip_id, PersonMedicaidIdentification
            has_many :preferred_languages, PersonPreferredLanguage
            has_many :incomes, PersonIncome
            has_many :expenses, PersonExpense
            has_many :employments, PersonEmploymentAssociation
            has_many :contacts, PersonContactInformationAssociation
            has_many :persons, PersonAssociation

            def self.domain_to_mapper(person_augmentation)
              mapper = self.new
              mapper.pregnancy_status = PersonPregnancyStatus.domain_to_mapper(person_augmentation.pregnancy_status)
              mapper.preferred_languages = person_augmentation.preferred_languages.map{ |preferred_language|
                PersonPreferredLanguage.domain_to_mapper(preferred_language)
              }
              mapper.incomes = person_augmentation.incomes.map{ |income|
                PersonIncome.domain_to_mapper(income)
              }
              mapper.employments = person_augmentation.employments.map{ |employment_association|
                PersonEmploymentAssociation.domain_to_mapper(employment_association)
              }
              # [PersonPreferredLanguage.domain_to_mapper(augmentation.person_preferred_language)]
              mapper.contacts = person_augmentation.contacts.map { |contact_association| 
                PersonContactInformationAssociation.domain_to_mapper(contact_association) 
              }
              # [PersonContactInformationAssociation.domain_to_mapper(augmentation.contact)]
              mapper.persons = person_augmentation.persons.map { |person_association|
                PersonAssociation.domain_to_mapper(person_association)
              }            
              # [PersonAssociation.domain_to_mapper(augmentation.person)]
            end

            def to_hash
              {
                us_naturalized_citizen_indicator: us_naturalized_citizen_indicator,
                us_veteran_indicator: us_veteran_indicator,
                married_indicator: married_indicator,
                pregancy_status: pregancy_status&.to_hash,
                medicaid_id: medicaid_id&.to_hash,
                chip_id: chip_id&.to_hash,
                preferred_languages: preferred_languages.map(&:to_hash),
                incomes: incomes.map(&:to_hash),
                expenses: expenses.map(&:to_hash),
                employments: employments.map(&:to_hash),
                contacts: contacts.map(&:to_hash),
                family_relationships: persons.map(&:to_hash)
              }
            end
          end
        end
      end
    end
  end
end