# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Contracts::Locations::AddressContract,  dbclean: :after_each do

  subject do
    described_class.new.call(params)
  end

  describe 'missing address1 field' do

    let(:params) do
      { has_fixed_address: true,
        kind: 'home',
        address_2: '1234',
        address_3: 'person',
        city: 'test',
        county: '',
        county_name: '',
        state: 'DC',
        zip: '12345',
        country_name: 'USA',
        validation_status: 'ValidMatch',
        start_on: '2021/1/12',
        end_on: nil,
        lives_outside_state_temporarily: false }
    end
    let(:error_message) { { :address_1 => ["is missing"] } }

    it 'fails' do
      expect(subject).not_to be_success
      expect(subject.errors.to_h).to eq error_message
    end
  end

  describe 'missing kind field' do

    let(:params) do
      { has_fixed_address: true,
        address_1: 'address one',
        address_2: '1234',
        address_3: 'person',
        city: 'test',
        county: '',
        county_name: '',
        state: 'DC',
        zip: '12345',
        country_name: 'USA',
        validation_status: 'ValidMatch',
        start_on: '2021/1/12',
        end_on: nil,
        lives_outside_state_temporarily: false }
    end
    let(:error_message) { { :kind => ["is missing"] } }

    it 'fails' do
      expect(subject).not_to be_success
      expect(subject.errors.to_h).to eq error_message
    end
  end

  describe 'missing city field' do

    let(:params) do
      { kind: 'home',
        address_1: '1234',
        address_2: '1234',
        address_3: 'person',
        county: '',
        state: 'DC',
        zip: '12345',
        county_name: '',
        has_fixed_address: true }
    end
    let(:error_message) { { :city => ["is missing"] } }

    it 'fails' do
      expect(subject).not_to be_success
      expect(subject.errors.to_h).to eq error_message
    end
  end

  describe 'missing state field' do

    let(:params) do
      { kind: 'home',
        address_1: '1234',
        address_2: '1234',
        address_3: 'person',
        city: 'test',
        county: '',
        zip: '12345',
        county_name: '',
        has_fixed_address: true }
    end
    let(:error_message) { { :state => ["is missing"] } }

    it 'fails' do
      expect(subject).not_to be_success
      expect(subject.errors.to_h).to eq error_message
    end
  end

  describe 'missing zip' do

    let(:params) do
      { kind: 'home',
        address_1: '1234',
        address_2: '1234',
        address_3: 'person',
        city: 'test',
        state: 'DC',
        county: '',
        county_name: '',
        has_fixed_address: true }
    end
    let(:error_message) { { :zip => ["is missing"] } }

    it 'fails' do
      expect(subject).not_to be_success
      expect(subject.errors.to_h).to eq error_message
    end
  end

  describe 'passing empty address_1, city, kind, state, zip' do

    let(:params) do
      { kind: 'home',
        address_1: '',
        address_2: '1234',
        address_3: 'person',
        city: '',
        state: '',
        zip: '',
        county: '',
        county_name: '',
        has_fixed_address: true }
    end
    let(:error_message) do
      { :address_1 => ["must be filled"], :city => ["must be filled"], :state => ["must be filled"], :zip => ["must be filled"] }
    end

    it 'fails' do
      expect(subject).not_to be_success
      expect(subject.errors.to_h).to eq error_message
    end
  end

  describe 'passing all fields with invalid zip address_1, city, kind, state, zip' do

    let(:params) do
      { kind: 'home',
        address_1: '1234',
        address_2: '1234',
        address_3: 'person',
        city: 'city',
        state: 'DC',
        zip: '223',
        county: '',
        county_name: '',
        has_fixed_address: true }
    end
    let(:error_message) do
      { :zip => ["is in invalid format"] }
    end

    it 'fails' do
      expect(subject).not_to be_success
      expect(subject.errors.to_h).to eq error_message
    end
  end

  describe 'invalid validation_status field' do

    let(:params) do
      {
        kind: 'home',
        address_1: '1234',
        address_2: '1234',
        address_3: 'person',
        city: 'test',
        county: '',
        state: 'DC',
        zip: '12345',
        county_name: '',
        has_fixed_address: true,
        validation_status: 'Test'
      }
    end
    let(:error_message) { { :validation_status => ['must be one of: ValidMatch, PartialMatch, NoStreet, NoCity'] } }

    it 'fails' do
      expect(subject).not_to be_success
      expect(subject.errors.to_h).to eq error_message
    end
  end

  describe 'all valid fields' do

    let(:params) do
      {
        kind: 'home',
        address_1: '1234',
        address_2: '1234',
        address_3: 'person',
        city: 'test',
        state: 'DC',
        zip: '12345',
        county: '',
        county_name: '',
        has_fixed_address: true,
        validation_status: 'ValidMatch'
      }
    end

    it 'passes' do
      expect(subject).to be_success
    end
  end
end
