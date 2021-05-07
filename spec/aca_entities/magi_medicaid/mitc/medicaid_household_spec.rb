# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/mitc_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Mitc::MedicaidHousehold do
  describe 'with valid arguments' do
    let(:medicaid_household) do
      { people: [100],
        magi_income: 25_608,
        magi_as_percentage_of_fpl: 3,
        size: 1 }
    end

    before do
      contract_params = ::AcaEntities::MagiMedicaid::Mitc::Contracts::MedicaidHouseholdContract.new.call(medicaid_household).to_h
      @result = described_class.new(contract_params)
    end

    it 'should return MedicaidHousehold entity object' do
      expect(@result).to be_a(described_class)
    end

    it 'should return all keys of MedicaidHousehold' do
      expect(@result.to_h.keys).to eq(medicaid_household.keys)
    end
  end
end
