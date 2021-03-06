# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/medicaid_specific_information'

RSpec.describe ::AcaEntities::Medicaid::Atp::MedicaidSpecificInformation do

  describe 'with valid arguments' do
    let(:input_params) do
      { medical_bills_in_last_90_days: true }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end
end
