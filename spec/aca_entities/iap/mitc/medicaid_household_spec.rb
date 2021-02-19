# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/iap/mitc/types'
require 'aca_entities/iap/mitc/person_reference'
require 'aca_entities/iap/mitc/medicaid_household'

RSpec.describe ::AcaEntities::Iap::Mitc::MedicaidHousehold do
  describe 'with valid arguments' do
    let(:input_params) do
      { people: [{person_id: 100}],
        magi_income: 100,
        size: 1}
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a ::AcaEntities::Iap::Mitc::MedicaidHousehold
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { subject }.to raise_error(Dry::Struct::Error)
    end
  end
end
