# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/mitc/types'
require 'aca_entities/medicaid/mitc/contracts/deprived_child_contract'

RSpec.describe ::AcaEntities::Medicaid::Mitc::Contracts::DeprivedChildContract do
  let(:required_params) { { qualify_as_deprived_child: 'N' } }

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
