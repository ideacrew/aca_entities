# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/mitc/types'
require 'aca_entities/magi_medicaid/mitc/contracts/person_reference_contract'
require 'aca_entities/magi_medicaid/mitc/contracts/household_contract'

RSpec.describe ::AcaEntities::MagiMedicaid::Mitc::Contracts::HouseholdContract do
  let(:required_params) { { household_id: '1000', people: [{ person_id: 100 }] } }

  context 'valid params' do
    it { expect(subject.call(required_params).success?).to be_truthy }
    it { expect(subject.call(required_params).to_h).to eq required_params }
  end

  context 'invalid params' do
    context 'with no parameters' do
      before :each do
        @result = subject.call({})
      end

      it 'should return a failure' do
        expect(@result.success?).to be_falsey
      end

      it 'should list error for every required parameter' do
        expect(@result.errors.to_h.keys).to match_array required_params.keys
      end
    end
  end
end
