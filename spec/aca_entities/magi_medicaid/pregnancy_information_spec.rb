# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::PregnancyInformation, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:input_params) do
      { is_pregnant: true,
        is_enrolled_on_medicaid: false,
        is_post_partum_period: false,
        expected_children_count: 1,
        pregnancy_due_on: Date.today.next_month,
        pregnancy_end_on: nil }
    end

    before do
      pregnancy_params = AcaEntities::MagiMedicaid::Contracts::PregnancyInformationContract.new.call(input_params).to_h
      @result = described_class.new(pregnancy_params)
    end

    it 'should return PregnancyInformation entity object' do
      expect(@result).to be_a(described_class)
    end

    it 'should return all keys of PregnancyInformation' do
      expect(@result.to_h.keys).to eq(input_params.keys)
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { described_class.new(is_pregnant: 'Test') }.to raise_error(Dry::Struct::Error, /has invalid type for :is_pregnant/)
    end
  end
end
