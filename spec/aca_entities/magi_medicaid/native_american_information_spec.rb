# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/native_american_information'

RSpec.describe ::AcaEntities::MagiMedicaid::NativeAmericanInformation, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:input_params) do
      { indian_tribe_member: false }
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
      msg = /invalid type for :indian_tribe_member violates constraints/
      expect { described_class.new(indian_tribe_member: 'Test') }.to raise_error(Dry::Struct::Error, msg)
    end
  end
end
