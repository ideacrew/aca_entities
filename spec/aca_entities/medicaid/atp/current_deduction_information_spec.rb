# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/current_deduction_information'

RSpec.describe ::AcaEntities::Medicaid::Atp::CurrentDeductionInformation do

  describe 'with valid arguments' do
    let(:input_params) do
      { category_code: 'Alimony',
        amount: 100.00,
        frequency_code: 'Weekly',
        category_text: 'Alimony' }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end
end
