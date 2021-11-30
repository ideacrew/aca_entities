# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/role_played_by_person_contract'

RSpec.describe ::AcaEntities::Medicaid::Contracts::RolePlayedByPersonContract, dbclean: :after_each do

  let(:required_params) do
    {
      person_name: person_name,
      sex: "SEX"
    }
  end

  let(:optional_params) do
    {
      birth_date: person_birth_date,
      person_augmentation: person_augmentation
    }
  end

  let(:person_name) do
    {
      given: "First",
      middle: "",
      sur: "Last",
      full: "First Last"
    }
  end

  let(:person_birth_date) do
    { date: Date.today - 50 }
  end

  let(:person_augmentation) do
    {}
  end

  let(:all_params) { required_params.merge(optional_params) }

  context 'invalid parameters' do
    context 'with empty parameters' do
      it 'should list error for every required parameter' do
        expect(subject.call({}).errors.to_h.keys).to match_array required_params.keys
      end
    end

    context 'with optional parameters only' do
      it 'should list error for every required parameter' do
        expect(subject.call(optional_params).errors.to_h.keys).to match_array required_params.keys
      end
    end
  end

  context 'valid parameters' do
    context 'with required parameters only' do
      it { expect(subject.call(required_params).success?).to be_truthy }
      it { expect(subject.call(required_params).to_h).to eq required_params }
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