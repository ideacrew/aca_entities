# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/other_insurance_detail'

RSpec.describe ::AcaEntities::Medicaid::Atp::OtherInsuranceDetail do

  describe 'with valid arguments' do
    let(:input_params) do
      { type_code: 'Private',
        insurance_name: 'Private Insurance',
        policy_number: '12345' }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end
end
