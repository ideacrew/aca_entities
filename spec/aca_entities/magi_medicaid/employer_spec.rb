# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Employer, dbclean: :after_each do
  describe 'with valid arguments' do
    let(:input_params) do
      { employer_name: 'Employer Test', employer_id: '123456789' }
    end

    before do
      employer_params = AcaEntities::MagiMedicaid::Contracts::EmployerContract.new.call(input_params).to_h
      @result = described_class.new(employer_params)
    end

    it 'should return employer entity object' do
      expect(@result).to be_a(described_class)
    end

    it 'should return all keys of employer' do
      expect(@result.to_h.keys).to eq(input_params.keys)
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { described_class.new(employer_name: 100) }.to raise_error(Dry::Struct::Error, /has invalid type for :employer_name/)
    end
  end
end
