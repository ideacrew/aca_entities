# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/current_income_employer'

RSpec.describe ::AcaEntities::CurrentIncomeEmployer do

  describe 'with valid arguments' do
    let(:input_params) do
      { street_1: 'street_1',
        street_2: 'street_2',
        city: 'city',
        state_code: 'DC',
        zip_code: '20001' }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end
end
