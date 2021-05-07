# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/mitc_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Mitc::Contracts::EligibilityResponseContract do
  let(:category_determination) do
    { category: 'Child Category',
      indicator_code: 'N',
      ineligibility_code: 115,
      ineligibility_reason: 'Applicant is 19 years of age or older and the state does not cover young adults under age 20 or 21' }
  end

  let(:medicaid_household) do
    { people: [{ person_id: 100 }],
      magi_income: 25_608,
      magi_as_percentage_of_fpl: 3,
      size: 1 }
  end

  let(:qualified_child) do
    { person_id: 101,
      determination: { dependent_age: { is_person_of_dependent_age: 'N' } },
      deprived_child: { qualify_as_deprived_child: 'N' },
      parent_caretaker_relationship: { containing_person_is_qualified_for_parent_caretaker_status: 'N' } }
  end

  let(:other_output) do
    { qualified_children_list: [qualified_child] }
  end

  let(:applicant_params) do
    { person_id: 100,
      medicaid_household: medicaid_household,
      is_medicaid_eligible: 'N',
      is_chip_eligible: 'N',
      medicaid_ineligibility_reasons: ['test'],
      is_eligible_for_non_magi_reasons: 'N',
      chip_ineligibility_reasons: ['test'],
      medicaid_category: 'Medicaid Category',
      medicaid_category_threshold: 100,
      chip_category: 'Chip Category',
      chip_category_threshold: 50,
      determinations: [category_determination],
      other_output: other_output }
  end

  let(:input_params) do
    { determination_date: Date.new, applicants: [applicant_params] }
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
        expect(@result.errors.to_h.keys).to match_array input_params.keys
      end
    end
  end
end
