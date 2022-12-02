# frozen_string_literal: true

require 'spec_helper'
require 'date'

RSpec.describe ::AcaEntities::Locations::Addresses::Contracts::StreetAddressContract do
  subject { described_class.new }

  let(:id) { '12345' }
  let(:kind) { 'home' }
  let(:street_predirection) { 'South' }
  let(:address_1) { '1406 Albright St' }
  let(:address_2) { 'Apt 123' }
  let(:address_3) { nil }
  let(:street_postdirection) { 'SE' }
  let(:city_name) { 'Boise' }
  let(:state_abbreviation) { 'ID' }
  let(:zip_code) { '83705' }
  let(:zip_plus_four_code) { '0587' }

  let(:county_name) { 'Ada' }
  let(:county_fips_code) { '16001' }
  let(:state_fips_code) { '16' }

  let(:country_name) { 'United States' }
  let(:country_code) { '001' }

  let(:validation_status) { { authority: 'SmartyStreets', validated_at: moment } }

  let(:has_fixed_address) { true }
  let(:lives_outside_state_temporarily) { false }

  let(:geographic_coordinates) { { latitiude: 43.614901, longitude: -116.202393 } }

  let(:today) { Date.today }
  let(:start_on) { today }
  let(:end_on) { today + 90 }

  let(:moment) { DateTime.now }
  let(:timestamps) { { created_at: moment, modified_at: moment } }

  let(:required_params) do
    {
      kind: kind,
      address_1: address_1,
      city_name: city_name,
      state_abbreviation: state_abbreviation,
      zip_code: zip_code
    }
  end

  let(:optional_params) do
    {
      id: id,
      street_predirection: street_predirection,
      address_2: address_2,
      address_3: address_3,
      street_postdirection: street_postdirection,
      zip_plus_four_code: zip_plus_four_code,
      county_name: county_name,
      county_fips_code: county_fips_code,
      country_name: country_name,
      country_code: country_code,
      validation_status: validation_status,
      start_on: start_on,
      end_on: end_on,
      has_fixed_address: has_fixed_address,
      lives_outside_state_temporarily: lives_outside_state_temporarily,
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
        city_name: ['is missing'],
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

  describe 'Zipcode validation' do
    context 'and the value size is not equal to five' do
      let(:too_short) { '1234' }
      let(:too_long) { '012345' }

      it 'should fail to validate' do
        expect { subject.call(required_params.merge(zip_code: too_short).success?).to be_falsey }
        expect { subject.call(required_params.merge(zip_code: too_long).success?).to be_falsey }
        # result = subject.call(parms)
        # expect(result.success?).to be_truthy
        # expect(result.to_h[:zip_plus_four]).to be_nil
      end
    end

    context 'and the value size is equal to four' do
      let(:just_right) { '04321' }

      it 'should validate' do
        expect { subject.call(required_params.merge(zip_code: just_right).success?).to be_truthy }
      end
    end

    context 'and the value is nil' do
      let(:parms) { required_params.merge(zip_code: nil) }

      it 'should fail to validate' do
        result = subject.call(parms)
        expect(result.to_h[:zip_code]).to be_nil
        expect(result.failure?).to be_truthy
      end
    end
  end

  describe 'When a ZipPlusFourCode key is present' do
    context 'and the value size is not equal to four' do
      let(:too_short) { '123' }
      let(:too_long) { '12345' }

      it 'should fail to validate' do
        expect { subject.call(required_params.merge(zip_plus_four_code: too_short).success?).to be_falsey }
        expect { subject.call(required_params.merge(zip_plus_four_code: too_long).success?).to be_falsey }
        # result = subject.call(parms)
        # expect(result.success?).to be_truthy
        # expect(result.to_h[:zip_plus_four]).to be_nil
      end
    end

    context 'and the value size is equal to four' do
      let(:just_right) { '4321' }

      it 'should validate' do
        expect { subject.call(required_params.merge(zip_plus_four_code: just_right).success?).to be_truthy }
      end
    end

    context 'and the value is nil' do
      let(:parms) { required_params.merge(zip_plus_four_code: nil) }

      it 'should validate' do
        result = subject.call(parms)
        expect(result.success?).to be_truthy
        expect(result.to_h[:zip_plus_four_code]).to be_nil
      end
    end
  end
end
