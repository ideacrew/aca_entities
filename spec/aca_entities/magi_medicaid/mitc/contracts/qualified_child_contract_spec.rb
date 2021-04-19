# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/mitc_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Mitc::Contracts::QualifiedChildContract do
  let(:required_params) do
    { person_id: 100,
      determination: { indicator_code: 'Y', ineligibility_code: 123, ineligibility_reason: 'Nothing' },
      deprived_child: { qualify_as_deprived_child: 'N' },
      relationship: { other_id: 100, attest_primary_responsibility: 'Y', relationship_code: '01' } }
  end

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
