# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp'
require 'aca_entities/serializers/xml/medicaid/atp'
require 'open3'

RSpec.describe AcaEntities::Serializers::Xml::Medicaid::Atp::Person do
  describe '#to_hash' do
    let(:person_instance) { described_class.new }

    before do
      person_instance.id = '123'
      person_instance.age_measure = double(to_hash: { age: 30 })
      person_instance.birth_date = double(to_hash: { date: '2000-01-01' })
      person_instance.ethnicities = ['Ethnicity1']
      person_instance.person_name = double(to_hash: { first_name: 'John', last_name: 'Doe' })
      person_instance.race = 'Race'
      person_instance.sex = 'Sex'
      person_instance.ssn_identification = double(to_hash: { ssn: '999-99-9999' })
      person_instance.us_citizen_indicator = double(value: true)
      person_instance.living_indicator = true
      person_instance.person_augmentation = double(to_hash: { additional_info: 'info' })
      person_instance.tribal_augmentation = double(to_hash: { tribe_name: 'Tribe' })
    end


    it 'returns a hash representation of the person object' do
      expected_hash = {
        id: '123',
        age_measure: { age: 30 },
        person_name: { first_name: 'John', last_name: 'Doe' },
        us_citizen_indicator: true,
        living_indicator: true,
        ssn_identification: { ssn: '999-99-9999' },
        sex: 'Sex',
        race: 'Race',
        ethnicities: ['Ethnicity1'],
        birth_date: { date: '2000-01-01' },
        tribal_augmentation: { tribe_name: 'Tribe' },
        augementation: { additional_info: 'info' }
      }

      expect(person_instance.to_hash).to eq(expected_hash)
    end
  end
end
