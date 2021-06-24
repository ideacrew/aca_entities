# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A data type that supplements an nc:Person with health insurance specific information.
          class PersonAugmentation
            include HappyMapper
            register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'

            tag 'PersonAugmentation'
            namespace 'hix-core'

            element :us_naturalized_citizen_indicator, Boolean, tag: "USNaturalizedCitizenIndicator", namespace: "hix-core"
            element :us_verteran_indicator, Boolean, tag: "PersonUSVeteranIndicator", namespace: "hix-core"
            element :married_indicator, Boolean, tag: 'PersonMarriedIndicator', namespace: "hix-core"
            has_one :pregancy_status, PersonPregnancyStatus
            has_one :medicaid_id, PersonMedicaidIdentification
            has_one :chip_id, PersonMedicaidIdentification
            has_many :preferred_languages, PersonPreferredLanguage
            has_many :incomes, PersonIncome
            has_many :expenses, PersonExpense
            has_many :employments, PersonEmploymentAssociation
            has_many :contacts, PersonContactInformationAssociation
            has_many :persons, PersonAssociation

            def self.domain_to_mapper(_person)
              self.new
            end

            def to_hash
              {
                us_naturalized_citizen_indicator: us_naturalized_citizen_indicator,
                us_verteran_indicator: us_verteran_indicator,
                married_indicator: married_indicator,
                pregancy_status: pregancy_status&.to_hash,
                medicaid_id: medicaid_id&.to_hash,
                chip_id: chip_id&.to_hash,
                preferred_languages: preferred_languages.map(&:to_hash),
                incomes: incomes.map(&:to_hash),
                expenses: expenses.map(&:to_hash),
                employments: employments.map(&:to_hash),
                contacts: contacts.map(&:to_hash),
                persons: persons.map(&:to_hash)
              }
            end
          end
        end
      end
    end
  end
end