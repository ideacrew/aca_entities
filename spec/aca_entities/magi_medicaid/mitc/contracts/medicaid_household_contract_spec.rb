# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/mitc/types'
require 'aca_entities/magi_medicaid/mitc/contracts/person_reference_contract'
require 'aca_entities/magi_medicaid/mitc/contracts/medicaid_household_contract'

RSpec.describe ::AcaEntities::MagiMedicaid::Mitc::Contracts::MedicaidHouseholdContract do
  let(:required_params) do
    { people: [{ person_id: 100 }, { person_id: 101 }], magi_income: 100, size: 2 }
  end

  context 'valid params' do
    it { expect(subject.call(required_params).success?).to be_truthy }
    it { expect(subject.call(required_params).to_h).to eq required_params }
  end

  context 'invalid params' do
    context 'with no parameters' do
      it 'should list error for every required parameter' do
        result = subject.call({})
        expect(result.success?).to be_falsey
        expect(result.errors.to_h.keys).to match_array required_params.keys
      end
    end
  end
end
