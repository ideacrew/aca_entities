# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::NativeAmericanInformation, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:input_params) do
      { indian_tribe_member: false }
    end

    before do
      nai_params = AcaEntities::MagiMedicaid::Contracts::NativeAmericanInformationContract.new.call(input_params).to_h
      @result = described_class.new(nai_params)
    end

    it 'should return NativeAmericanInformation entity object' do
      expect(@result).to be_a(described_class)
    end

    it 'should return all keys of NativeAmericanInformation' do
      expect(@result.to_h.keys).to eq(input_params.keys)
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      msg = /invalid type for :indian_tribe_member violates constraints/
      expect { described_class.new(indian_tribe_member: 'Test') }.to raise_error(Dry::Struct::Error, msg)
    end
  end
end
