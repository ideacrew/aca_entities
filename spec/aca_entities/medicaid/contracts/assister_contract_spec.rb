# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/assister_contract'

RSpec.describe ::AcaEntities::Medicaid::Contracts::AssisterContract, dbclean: :after_each do

  let(:required_params) { {} }

  let(:optional_params) do
    {
      role_played_by_person: role_played_by_person
    }
  end

  let(:role_played_by_person) do
    {
      person_name: person_name,
      sex: "SEX"
    }
  end

  let(:person_name) do
    { given: 'first',
      middle: 'middle',
      sur: 'last',
      full: 'prefix first middle last suffix' }
  end

  let(:all_params) { required_params.merge(optional_params)}

  context 'valid parameters' do
    context 'with optional parameters only' do

      before do
        @result = subject.call(optional_params)
      end

      it { expect(@result.success?).to be_truthy }
      it { expect(@result.to_h).to eq optional_params }
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
