# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::FosterCare, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:input_params) do
      { is_former_foster_care: true,
        age_left_foster_care: 15,
        foster_care_us_state: 'DC',
        had_medicaid_during_foster_care: false }
    end

    before do
      foster_care_params = AcaEntities::MagiMedicaid::Contracts::FosterCareContract.new.call(input_params).to_h
      @result = described_class.new(foster_care_params)
    end

    it 'should return foster_care entity object' do
      expect(@result).to be_a(described_class)
    end

    it 'should return all keys of foster_care' do
      expect(@result.to_h.keys).to eq(input_params.keys)
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { described_class.new(foster_care_us_state: 'Test') }.to raise_error(Dry::Struct::Error, /has invalid type for :foster_care_us_state/)
    end
  end
end
