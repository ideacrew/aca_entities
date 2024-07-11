# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::ApplicantReference do

  describe 'with valid arguments' do
    let(:input_params) do
      { first_name: 'First Test',
        last_name: 'Last Test',
        dob: Date.today.prev_year,
        person_hbx_id: '1000' }
    end

    before do
      app_ref_params = AcaEntities::MagiMedicaid::Contracts::ApplicantReferenceContract.new.call(input_params).to_h
      @result = described_class.new(app_ref_params)
    end

    it 'should return applicant_reference entity object' do
      expect(@result).to be_a(described_class)
    end

    it 'should return all keys of applicant_reference' do
      expect(@result.to_h.keys).to eq(input_params.keys)
    end
  end

  describe 'with invalid arguments' do
    context 'no params' do
      it 'should raise error' do
        expect { subject }.to raise_error(Dry::Struct::Error, /:first_name is missing/)
      end
    end

    context 'bad input values' do
      it 'should raise error' do
        expect { described_class.new(first_name: 100) }.to raise_error(Dry::Struct::Error, /has invalid type for :first_name/)
      end
    end
  end
end
