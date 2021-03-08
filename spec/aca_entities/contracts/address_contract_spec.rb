# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/contracts/address_contract'

RSpec.describe ::AcaEntities::Contracts::AddressContract,  dbclean: :after_each do

  subject do
    described_class.new.call(params)
  end

  describe 'missing address1 field' do

    let(:params) do
      { kind: 'home',
        address_2: '1234',
        address_3: 'person',
        city: 'test',
        county: '',
        state: 'DC',
        zip: '12345',
        county_name: '',
        has_fixed_address: true }
    end
    let(:error_message) { { :has_fixed_address => ['Address1 cannot be blank'] } }

    it 'fails' do
      expect(subject).not_to be_success
      expect(subject.errors.to_h).to eq error_message
    end
  end

  describe 'missing kind field' do

    let(:params) do
      { address_1: 'test',
        address_2: '1234',
        address_3: 'person',
        city: 'test',
        county: '',
        state: 'DC',
        zip: '12345',
        county_name: '',
        has_fixed_address: true }
    end
    let(:error_message) { { :has_fixed_address => ['Kind cannot be blank'] } }

    it 'fails' do
      expect(subject).not_to be_success
      expect(subject.errors.to_h).to eq error_message
    end
  end

  describe 'missing city field' do

    let(:params) do
      { kind: 'test',
        address_1: '1234',
        address_2: '1234',
        address_3: 'person',
        county: '',
        state: 'DC',
        zip: '12345',
        county_name: '',
        has_fixed_address: true }
    end
    let(:error_message) { { :has_fixed_address => ['City cannot be blank'] } }

    it 'fails' do
      expect(subject).not_to be_success
      expect(subject.errors.to_h).to eq error_message
    end
  end

  describe 'missing state field' do

    let(:params) do
      { kind: 'test',
        address_1: '1234',
        address_2: '1234',
        address_3: 'person',
        city: 'test',
        county: '',
        zip: '12345',
        county_name: '',
        has_fixed_address: true }
    end
    let(:error_message) { { :has_fixed_address => ['State cannot be blank'] } }

    it 'fails' do
      expect(subject).not_to be_success
      expect(subject.errors.to_h).to eq error_message
    end
  end

  describe 'missing zip' do

    let(:params) do
      { kind: 'test',
        address_1: '1234',
        address_2: '1234',
        address_3: 'person',
        city: 'test',
        state: 'DC',
        county: '',
        county_name: '',
        has_fixed_address: true }
    end
    let(:error_message) { { :has_fixed_address => ['Zip cannot be blank'] } }

    it 'fails' do
      expect(subject).not_to be_success
      expect(subject.errors.to_h).to eq error_message
    end
  end

  describe 'passing empty address_1, city, kind, state, zip' do

    let(:params) do
      { kind: 'test',
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
      { :has_fixed_address => ['Address1 cannot be blank',
                               'City cannot be blank',
                               'State cannot be blank',
                               'Zip cannot be blank'] }
    end

    it 'fails' do
      expect(subject).not_to be_success
      expect(subject.errors.to_h).to eq error_message
    end
  end

  describe 'passing all fields with invalid zip address_1, city, kind, state, zip' do

    let(:params) do
      { kind: 'test',
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
      { :has_fixed_address => ['Zip should be in the form: 12345 or 12345-1234'] }
    end

    it 'fails' do
      expect(subject).not_to be_success
      expect(subject.errors.to_h).to eq error_message
    end
  end

  describe 'all valid fields' do

    let(:params) do
      { kind: 'test',
        address_1: '1234',
        address_2: '1234',
        address_3: 'person',
        city: 'test',
        state: 'DC',
        zip: '12345',
        county: '',
        county_name: '',
        has_fixed_address: true }
    end

    it 'passes' do
      expect(subject).to be_success
    end
  end
end
