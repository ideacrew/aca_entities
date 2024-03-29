# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/magi_income_basis_contract'

RSpec.describe ::AcaEntities::Medicaid::Contracts::MagiIncomeBasisContract,  dbclean: :around_each do

  it 'should be a container-ready operation' do
    expect(subject.respond_to?(:call)).to be_truthy
  end

  let(:required_params) {{ medicaid_status_code: "200" }}

  let(:all_params) do
    required_params.merge(
      medicaid_status_indicator: true,
      medicaid_status_determination_date: DateTime.now,
      medicaid_inconsistency_reason: "reason for inconsistency",
      medicaid_ineligibility_reason: "reason for ineligibility",
      income_verified_data_source: "enroll_source",
      annual_income_verification_status: true,
      annual_income_inconsistency_reason: "reason for inconsistency",
      annual_income_determination_date: DateTime.now,
      annual_income_verification_source: "Test source",
      income_eligible_under_rpc: false,
      applicable_medicaid_standard: 200
    )
  end

  context 'success case' do
    it 'should return success without any errors when required params passed' do
      result = subject.call(required_params)
      expect(result.success?).to be_truthy
      expect(result.errors.empty?).to be_truthy
    end

    it 'should return success without any errors when all params passed' do
      result = subject.call(all_params)
      expect(result.success?).to be_truthy
      expect(result.errors.empty?).to be_truthy
    end
  end

  context 'failure case' do
    context 'without all required params' do

      it 'should return failure with errors' do
        result = subject.call({})
        expect(result.failure?).to be_truthy
        expect(result.errors.empty?).to be_falsy
        expect(result.errors.to_h).to eq({ :medicaid_status_code => ["is missing"] })
      end
    end

    context 'invalid input for status code' do
      it 'should return failure with error message' do
        result = subject.call({ medicaid_status_code: 200 })
        expect(result.failure?).to be_truthy
        expect(result.errors.empty?).to be_falsy
        expect(result.errors.to_h).to eq({ :medicaid_status_code => ["must be a string"] })
      end
    end

    context 'invalid input for determination_date' do
      it 'should return error message' do
        result = subject.call(required_params.merge(medicaid_status_determination_date: "end date"))
        expect(result.errors.to_h).to eq({ :medicaid_status_determination_date => ["must be a date time"] })
      end
    end
  end
end
