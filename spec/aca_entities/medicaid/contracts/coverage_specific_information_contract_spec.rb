# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/coverage_specific_information_contract'

RSpec.describe ::AcaEntities::Medicaid::Contracts::CoverageSpecificInformationContract, dbclean: :after_each do

  let(:required_params) { {} }

  let(:optional_params) do
    { coverage_type_code: 'EmergencyMedicaid',
      aptc: 20.00,
      net_premium: 80.00,
      qhp_issuer_id: nil,
      qhp_id: nil,
      metal_level_code: 'Platinum',
      issuer_name: 'KP',
      plan_name: 'Test Plan' }
  end

  let(:all_params) { required_params.merge(optional_params)}

  context 'invalid parameters' do
    context 'with empty parameters' do
      it 'should list error for every required parameter' do
        expect(subject.call({}).errors.to_h.keys).to match_array required_params.keys
      end
    end

    context 'coverage_type_code is QHP' do
      let(:input_params) { optional_params.merge({ coverage_type_code: 'QHP' }) }

      before do
        @result = subject.call(input_params)
      end

      it 'return failure with error message' do
        msg = { coverage_type_code: ['qhp_issuer_id must be populated.', 'qhp_id must be populated.'] }
        expect(@result.errors.to_h).to eq(msg)
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

    context 'coverage_type_code is QHP' do
      let(:input_params) { optional_params.merge({ coverage_type_code: 'QHP', qhp_issuer_id: '95', qhp_id: '04' }) }

      before do
        @result = subject.call(input_params)
      end

      it { expect(@result.success?).to be_truthy }
      it { expect(@result.to_h).to eq(input_params) }
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
