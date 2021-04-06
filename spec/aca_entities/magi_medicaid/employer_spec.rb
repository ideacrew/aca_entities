# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Employer, dbclean: :after_each do
  describe 'with valid arguments' do
    let(:input_params) do
      { employer_name: 'Employer Test', employer_id: '123456789' }
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
      expect { described_class.new(employer_name: 100) }.to raise_error(Dry::Struct::Error, /has invalid type for :employer_name/)
    end
  end
end
