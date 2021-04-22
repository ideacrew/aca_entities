# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/mitc_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Mitc::Contracts::QualifiedChildContract do
  let(:required_params) do
    { person_id: 101,
      determination: { dependent_age: { is_person_of_dependent_age: 'N' } },
      deprived_child: { qualify_as_deprived_child: 'N' } }
  end

  let(:optional_params) do
    { parent_caretaker_relationship: { containing_person_is_qualified_for_parent_caretaker_status: 'N' } }
  end

  let(:input_params) do
    required_params.merge(optional_params)
  end

  context 'valid params' do
    it { expect(subject.call(input_params).success?).to be_truthy }
    it { expect(subject.call(input_params).to_h).to eq input_params }
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
