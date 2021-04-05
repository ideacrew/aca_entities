# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/non_magi_eligibility_basis_contract'

RSpec.describe ::AcaEntities::Medicaid::Contracts::NonMagiEligibilityBasisContract, dbclean: :around_each do

  it 'should be a container-ready operation' do
    expect(subject.respond_to?(:call)).to be_truthy
  end

  let(:required_params) {{}}

  let(:all_params) do
    required_params.merge(
      person_disabled: true,
      person_disable_status_code: "status code",
      medicare_entitlement: false,
      medicare_entitlement_status_code: 'code'
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
    context 'invalid input for status code' do
      it 'should return failure with error message' do
        result = subject.call({ person_disabled: 'test' })
        expect(result.failure?).to be_truthy
        expect(result.errors.empty?).to be_falsy
        expect(result.errors.to_h).to eq({ :person_disabled => ["must be boolean"] })
      end
    end

    context 'invalid input for determination_date' do
      it 'should return error message' do
        result = subject.call(required_params.merge(medicare_entitlement_status_code: 200))
        expect(result.errors.to_h).to eq({ :medicare_entitlement_status_code => ["must be a string"] })
      end
    end
  end
end
