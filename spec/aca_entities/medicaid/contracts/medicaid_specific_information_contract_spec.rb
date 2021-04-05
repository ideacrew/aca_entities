# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/medicaid_specific_information_contract'

RSpec.describe AcaEntities::Medicaid::Contracts::MedicaidSpecificInformationContract, type: :model do

  it 'should be a container-ready operation' do
    expect(subject.respond_to?(:call)).to be_truthy
  end

  context 'success case' do
    let(:input_params) do
      { medical_bills_in_last_90_days: true }
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
      { medical_bills_in_last_90_days: 'Test' }
    end

    it 'should return failure with errors' do
      expect(subject.call(input_params).errors.to_h).to eq({ medical_bills_in_last_90_days: ['must be boolean'] })
    end
  end
end
