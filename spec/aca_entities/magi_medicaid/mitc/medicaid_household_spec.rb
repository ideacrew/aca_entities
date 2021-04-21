# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/mitc_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Mitc::MedicaidHousehold do
  describe 'with valid arguments' do
    let(:person_reference) { { person_id: 100 } }
    let(:medicaid_household) do
      { people: [person_reference],
        magi_income: 25_608,
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

    it 'should match all the input keys of person_reference' do
      result_pr_keys = @result.to_h[:people].first.keys
      input_pr_keys = person_reference.keys
      expect(result_pr_keys - input_pr_keys).to be_empty
      expect(input_pr_keys - result_pr_keys).to be_empty
    end
  end
end
