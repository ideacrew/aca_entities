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

            has_many :persons, PersonAssociation
            has_many :contacts, PersonContactInformationAssociation
            has_many :employments, PersonEmploymentAssociation
            has_one :pregnancy_status, PersonPregnancyStatus
            has_one :medicaid_id, PersonMedicaidIdentification
            has_many :incomes, PersonIncome
            has_many :preferred_languages, PersonPreferredLanguage
            has_one :chip_id, PersonMedicaidIdentification
            element :us_naturalized_citizen_indicator, Boolean, tag: "USNaturalizedCitizenIndicator", namespace: "hix-core"
            has_many :expenses, PersonExpense
            element :married_indicator, Boolean, tag: 'PersonMarriedIndicator', namespace: "hix-core"
            element :us_veteran_indicator, Boolean, tag: "PersonUSVeteranIndicator", namespace: "hix-core"

            def self.domain_to_mapper(person_augmentation)
              mapper = self.new
              if person_augmentation
                mapper.us_veteran_indicator = person_augmentation.us_veteran_indicator
                mapper.married_indicator = person_augmentation.married_indicator              
                mapper.married_indicator = PersonMarriedIndicator.domain_to_mapper(person_augmentation.married_indicator)
                mapper.us_veteran_indicator = person_augmentation.us_veteran_indicator
                mapper.pregnancy_status = PersonPregnancyStatus.domain_to_mapper(person_augmentation.pregnancy_status)
                mapper.preferred_languages = person_augmentation.preferred_languages.map  do |preferred_language|
                  PersonPreferredLanguage.domain_to_mapper(preferred_language)
                end
                mapper.incomes = person_augmentation.incomes&.map  do |income|
                  PersonIncome.domain_to_mapper(income)
                end
                mapper.employments = person_augmentation.employments&.map  do |employment_association|
                  PersonEmploymentAssociation.domain_to_mapper(employment_association)
                end
                mapper.contacts = person_augmentation.contacts&.map do |contact_association|
                  PersonContactInformationAssociation.domain_to_mapper(contact_association)
                end
                mapper.persons = person_augmentation.persons&.map do |person_association|
                  PersonAssociation.domain_to_mapper(person_association)
                end
              end
              mapper
            end

            def to_hash
              {
                us_naturalized_citizen_indicator: us_naturalized_citizen_indicator,
                us_veteran_indicator: us_veteran_indicator,
                married_indicator: married_indicator,
                pregnancy_status: pregnancy_status&.to_hash,
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