# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Locations::Addresses::Contracts::AddressContract do
  subject { described_class.new }

  let(:id) { '12345' }
  let(:has_fixed_address) { true }
  let(:kind) { 'home' }
  let(:address_1) { '1406 Albright St' }
  let(:address_2) { 'NE' }
  let(:address_3) { 'Apt 123' }
  let(:city) { 'Boise' }
  let(:state) { 'ID' }
  let(:zip) { '83705' }

  let(:county) { 'Ada' }
  let(:county_code) { '16001' }

  let(:country_name) { 'United States' }
  let(:country_code) { '001' }

  let(:validation_status) { { authority: 'SmartyStreets', validated_at: moment } }

  let(:lives_outside_state_temporarily) { false }

  let(:geographic_coordinates) { { latitiude: 43.614901, longitude: -116.202393 } }

  let(:start_on) { moment }
  let(:end_on) { nil }

  let(:moment) { DateTime.now }
  let(:timestamps) { { created_at: moment, modified_at: moment } }

  let(:required_params) { { kind: kind, address_1: address_1, city: city, state: state, zip: zip } }
  let(:optional_params) do
    {
      id: id,
      address_2: address_2,
      address_3: address_3,
      county: county,
      county_code: county_code,
      country_name: country_name,
      country_code: country_code,
      validation_status: validation_status,
      start_on: start_on,
      end_on: end_on,
      timestamps: timestamps
    }
  end

  let(:all_params) { required_params.merge(optional_params) }

  context 'Calling contract with Valid params' do
    context 'Calling the contract with required params' do
      it 'should pass validation' do
        result = subject.call(required_params)
        expect(result.success?).to be_truthy
        expect(result.to_h).to eq required_params
      end
    end

    context 'Calling the contract with all params' do
      it 'should pass validation' do
        result = subject.call(all_params)
        expect(result.success?).to be_truthy
        expect(result.to_h).to eq all_params
      end
    end
  end

  context 'Calling the contract with no params' do
    let(:error_message) do
      {
        kind: ['is missing'],
        address_1: ['is missing'],
        city: ['is missing'],
        state: ['is missing'],
        zip: ['is missing']
      }
    end

    it 'should pass validation' do
      result = subject.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end
end
