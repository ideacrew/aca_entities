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

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { described_class.new(foster_care_us_state: 'Test') }.to raise_error(Dry::Struct::Error, /has invalid type for :foster_care_us_state/)
    end
  end
end
