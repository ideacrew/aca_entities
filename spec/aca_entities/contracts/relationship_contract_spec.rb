# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/contracts/relationship_contract'

RSpec.describe ::AcaEntities::Contracts::RelationshipContract, dbclean: :after_each do

  let(:required_params) { {} }

  let(:optional_params) do
    { relationship_to_tax_filer_code: '01',
      attested_child_of_caretaker_code: 'YesCovered',
      absent_parent_code: 'Yes',
      attested_caretaker: true,
      lives_with_minor_age_dependent: false,
      lives_with_other_parent_not_claimer: false,
      person_for_work_quarters: false,
      parent_caretaker_to_child_relationship_code: '01',
      parent1_hours_worked_per_week: 10,
      parent2_hours_worked_per_week: 10 }
  end

  let(:all_params) { required_params.merge(optional_params)}

  context 'invalid parameters' do
    context 'with empty parameters' do
      it 'should list error for every required parameter' do
        expect(subject.call({}).errors.to_h.keys).to match_array required_params.keys
      end
    end
  end

  context 'valid parameters' do
    context 'with required parameters only' do
      let(:input_params) { {} }

      before do
        @result = subject.call(input_params)
      end

      it { expect(@result.success?).to be_truthy }
      it { expect(@result.to_h).to eq input_params }
    end

    context 'with all required and optional parameters' do
      it 'should pass validation' do
        result = subject.call(all_params)
        expect(result.success?).to be_truthy
        expect(result.to_h).to eq all_params
      end
    end
  end
end
