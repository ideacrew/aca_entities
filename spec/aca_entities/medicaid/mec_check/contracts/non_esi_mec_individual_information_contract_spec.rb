# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/mec_check'

RSpec.describe AcaEntities::Medicaid::MecCheck::Contracts::NonEsiMecIndividualInformationContract, dbclean: :after_each do

  let(:required_params) do
    {
      person_name: { first_name: 'Bob', last_name: 'McBob' },
      person_date_of_birth: Date.parse("01/01/2010"),
      requested_insurance_period: { start_date: (Time.now - 604_800).to_date, end_date: Date.today },
      organization_code: 'CHIP'
    }
  end

  let(:optional_params) do
    {
      person_sex_code: 'M',
      person_ssn: '666666677',
    }
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