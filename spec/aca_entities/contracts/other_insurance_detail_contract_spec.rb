# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/contracts/other_insurance_detail_contract'

RSpec.describe AcaEntities::Contracts::OtherInsuranceDetailContract, type: :model do

  it 'should be a container-ready operation' do
    expect(subject.respond_to?(:call)).to be_truthy
  end

  context 'success case' do
    let(:input_params) do
      { type_code: 'Private',
        insurance_name: 'Private Insurance',
        policy_number: '12345' }
    end

    before do
      @result = subject.call(input_params)
    end

    it 'should return success' do
      expect(@result.success?).to be_truthy
    end

    it 'should not have any errors' do
      expect(@result.errors.empty?).to be_truthy
    end
  end

  context 'invalid params' do
    let(:input_params) do
      { type_code: 'Private',
        insurance_name: 128,
        policy_number: '12345' }
    end

    it 'should return failure with errors' do
      expect(subject.call(input_params).errors.to_h).to eq({ insurance_name: ['must be a string'] })
    end
  end
end
