# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Locations::Contracts::SiteAddressContract do
  subject { described_class.new }

  let(:id) { '12345' }
  let(:kind) { 'home' }
  let(:address_1) { '1406 Albright St' }
  let(:address_2) { 'NE' }
  let(:address_3) { 'Apt 123' }
  let(:full_address) { nil }
  let(:city) { 'Boise' }
  let(:state_abbreviation) { 'ID' }
  let(:county_name) { 'Ada' }
  let(:county_fips_code) { '16001' }
  let(:state_fips_code) { '16' }
  let(:zip_code) { '83705' }
  let(:zip_plus_four) { nil }
  let(:country_name) { nil }
  let(:country_code) { nil }
  let(:validation_status) { { authority: 'SmartyStreets', validated_on: moment } }
  let(:start_on) { moment }
  let(:end_on) { nil }

  let(:moment) { DateTime.now }
  let(:timestamps) { { created_at: moment, modified_at: moment } }

  let(:required_params) do
    { kind: kind, address_1: address_1, city: city, state_abbreviation: state_abbreviation, zip_code: zip_code }
  end
  let(:optional_params) do
    {
      id: id,
      address_2: address_2,
      address_3: address_3,
      zip_plus_four: zip_plus_four,
      full_address: full_address,
      county_name: county_name,
      county_fips_code: county_fips_code,
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
        state_abbreviation: ['is missing'],
        zip_code: ['is missing']
      }
    end

    it 'should pass validation' do
      result = subject.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end
end
