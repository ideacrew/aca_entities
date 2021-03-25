# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/person_name'
require 'aca_entities/magi_medicaid/types'
require 'aca_entities/magi_medicaid/employer'
require 'aca_entities/magi_medicaid/identifying_information'
require 'aca_entities/magi_medicaid/demographic'
require 'aca_entities/magi_medicaid/attestation'
require 'aca_entities/magi_medicaid/native_american_information'
require 'aca_entities/magi_medicaid/citizenship_immigration_status_information'
require 'aca_entities/magi_medicaid/student'
require 'aca_entities/magi_medicaid/pregnancy_information'
require 'aca_entities/magi_medicaid/foster_care'
require 'aca_entities/magi_medicaid/email'
require 'aca_entities/magi_medicaid/phone'
require 'aca_entities/magi_medicaid/income'
require 'aca_entities/magi_medicaid/benefit'
require 'aca_entities/magi_medicaid/deduction'
require 'aca_entities/magi_medicaid/applicant'

RSpec.describe ::AcaEntities::MagiMedicaid::Applicant, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:person_name) do
      { first_name: 'First', last_name: 'Last' }
    end
    let(:identifying_information) { { has_ssn: false } }
    let(:demographic) { { gender:  'Male', dob: Date.today.prev_year } }
    let(:attestation) do
      { is_incarcerated: false,
        is_disabled: false,
        is_self_attested_long_term_care: false }
    end
    let(:native_american_information) { { indian_tribe_member: false } }
    let(:citizenship_immigration_status_information) { { citizen_status: 'us_citizen' } }
    let(:address) do
      { has_fixed_address: true,
        kind: 'home',
        address_1: '123',
        address_2: '',
        address_3: '',
        city: 'was',
        county: '',
        country_code: '',
        state: 'DC',
        zip: '12321',
        country_name: '',
        validation_status: nil,
        start_on: nil,
        end_on: nil,
        lives_outside_state_temporarily: false }
    end
    let(:input_params) do
      { name: person_name,
        identifying_information: identifying_information,
        demographic: demographic,
        attestation: attestation,
        is_primary_applicant: true,
        native_american_information: native_american_information,
        citizenship_immigration_status_information: citizenship_immigration_status_information,
        person_hbx_id: '100',
        addresses: [address] }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { subject }.to raise_error(Dry::Struct::Error, /:first_name is missing in Hash input/)
    end
  end
end
