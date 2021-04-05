# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/basis_for_income'

RSpec.describe ::AcaEntities::Medicaid::Atp::BasisForIncome do

  describe 'with valid arguments' do
    let(:input_params) do
      {
        ssa_citizenship_status: true
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
