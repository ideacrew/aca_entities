# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/chip_medicaid_residency_eligibility_basis_contract'

RSpec.describe ::AcaEntities::Medicaid::Contracts::ChipMedicaidResidencyEligibilityBasisContract,  dbclean: :around_each do

  # it 'should be a container-ready operation' do
  #   expect(subject.respond_to?(:call)).to be_truthy
  # end

  # let(:required_params) {{ status_code: "200" }}

  # let(:all_params) do
  #   required_params.merge(
  #     status_indicator: true,
  #     status_determination_date: DateTime.now,
  #     ineligibility_reason: "reason for in eligibility"
  #   )
  # end

  # context 'success case' do
  #   it 'should return success without any errors when required params passed' do
  #     result = subject.call(required_params)
  #     expect(result.success?).to be_truthy
  #     expect(result.errors.empty?).to be_truthy
  #   end

  #   it 'should return success without any errors when all params passed' do
  #     result = subject.call(all_params)
  #     expect(result.success?).to be_truthy
  #     expect(result.errors.empty?).to be_truthy
  #   end
  # end

  # context 'failure case' do
  #   context 'without all required params' do

  #     it 'should return failure with errors' do
  #       result = subject.call({})
  #       expect(result.failure?).to be_truthy
  #       expect(result.errors.empty?).to be_falsy
  #       expect(result.errors.to_h).to eq({ :status_code => ["is missing"] })
  #     end
  #   end

  #   context 'invalid input for status code' do
  #     it 'should return failure with error message' do
  #       result = subject.call({ status_code: 200 })
  #       expect(result.failure?).to be_truthy
  #       expect(result.errors.empty?).to be_falsy
  #       expect(result.errors.to_h).to eq({ :status_code => ["must be a string"] })
  #     end
  #   end

  #   context 'invalid input for status_determination_date' do
  #     it 'should return error message' do
  #       result = subject.call(required_params.merge(status_determination_date: "end date"))
  #       expect(result.errors.to_h).to eq({ :status_determination_date => ["must be a date time"] })
  #     end
  #   end
  # end

  it 'should inherit from EligibilityBasisContract class' do
    expect(described_class).to be < ::AcaEntities::Medicaid::Contracts::EligibilityBasisContract
  end
end

