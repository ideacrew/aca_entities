# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/household_composition'

RSpec.describe ::AcaEntities::Medicaid::Atp::HouseholdComposition do

  describe 'with valid arguments' do
    let(:input_params) do
      {
        medicaid_household_size: 3,
        qualified_children_list: 'Sansa, Stark'
      }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end
end
