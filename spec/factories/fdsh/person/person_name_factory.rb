# frozen_string_literal: true

FactoryBot.define do
  factory :fdsh_person_name, class: 'AcaEntities::Fdsh::Person::PersonName' do
    PersonGivenName() { 'Michael' }
    PersonMiddleName() { 'J' }
    PersonSurName() { 'Brady' }
  end
end
