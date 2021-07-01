# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/insurance_application_contract'

RSpec.describe AcaEntities::Medicaid::Contracts::InsuranceApplicationContract, type: :model do

  # it 'should be a container-ready operation' do
  #   expect(subject.respond_to?(:call)).to be_truthy
  # end

  let(:required_params) do
    {
      insurance_applicants: [insurance_applicant],
      requesting_financial_assistance: false, 
      requesting_medicaid: false, 
      ssf_primary_contact: ssf_primary_contact, 
      tax_return_access_indicator: false
    }
  end

  let(:insurance_applicant) do
    { 
      role_reference: { ref: "a-person-id" } 
    }
  end

  let(:ssf_primary_contact) do
    { 
      role_reference: { ref: "a-person-id" },
      contact_preference: "Email"
    }
  end

  let(:optional_params) { {} }

  let(:all_params) { required_params.merge(optional_params)}


  # context 'success case' do
  #   before do
  #     @result = subject.call(input_params)
  #   end

  #   it 'should return success' do
  #     expect(@result.success?).to be_truthy
  #   end

  #   it 'should not have any errors' do
  #     expect(@result.errors.empty?).to be_truthy
  #   end
  # end

  context 'invalid parameters' do
    context 'with empty parameters' do
      it 'should list error for every required parameter' do
        expect(subject.call({}).errors.to_h.keys).to match_array required_params.keys
      end
    end

    context 'with optional parameters only' do
      it { expect(subject.call(optional_params).error?(required_params.first[0])).to be_truthy }
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
