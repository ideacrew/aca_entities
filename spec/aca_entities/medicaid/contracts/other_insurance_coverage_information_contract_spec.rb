# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/other_insurance_coverage_information_contract'

RSpec.describe AcaEntities::Medicaid::Contracts::OtherInsuranceCoverageInformationContract, type: :model do

  it 'should be a container-ready operation' do
    expect(subject.respond_to?(:call)).to be_truthy
  end

  context 'success case' do
    let(:input_params) do
      { lost_insurance_within_waiting_period: true,
        coverage_ended_reason_code: 'UnpaidPremium',
        enrolled_in_other_insurance: false,
        has_access_to_state_employee_health_plan: false }
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
      { lost_insurance_within_waiting_period: true,
        coverage_ended_reason_code: 'UnpaidPremium',
        enrolled_in_other_insurance: 'test',
        has_access_to_state_employee_health_plan: false }
    end

    it 'should return failure with errors' do
      expect(subject.call(input_params).errors.to_h).to eq({ enrolled_in_other_insurance: ['must be boolean'] })
    end
  end
end
