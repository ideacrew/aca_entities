# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/mitc_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Mitc::TaxReturn do
  describe 'with valid arguments' do
    let(:tax_return) { { filers: [{ person_id: 100 }], dependents: [{ person_id: 101 }] } }

    before do
      contract_params = ::AcaEntities::MagiMedicaid::Mitc::Contracts::TaxReturnContract.new.call(tax_return).to_h
      @result = described_class.new(contract_params)
    end

    it 'should return tax_return entity object' do
      expect(@result).to be_a(described_class)
    end

    it 'should return all keys of tax_return' do
      expect(@result.to_h.keys).to eq(tax_return.keys)
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { subject }.to raise_error(Dry::Struct::Error)
    end
  end
end
