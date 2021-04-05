# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/mitc/types'
require 'aca_entities/magi_medicaid/mitc/person_reference'
require 'aca_entities/magi_medicaid/mitc/tax_return'

RSpec.describe ::AcaEntities::MagiMedicaid::Mitc::TaxReturn do
  describe 'with valid arguments' do
    let(:input_params) do
      { filers: [{ person_id: 100 }], dependents: [{ person_id: 101 }] }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a ::AcaEntities::MagiMedicaid::Mitc::TaxReturn
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
