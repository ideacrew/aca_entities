# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/ios'

RSpec.describe AcaEntities::Medicaid::Ios::Contracts::SSPNonCustodialParentCContract, dbclean: :after_each do

  let(:required_params) do
    {
      FirstName__c: "First",
      LastName__c: "Last"
    }
  end

  let(:optional_params) do
    {
      MiddleInitial__c: "O",
      SSN__c: "123456789",
      SuffixCode__c: "ESQ",
      IndividualId__c: 1234,
      GenderCode__c: "F",
      Id: "Id",
      DCNonCustodialParentId__c: 2345,
      DateOfBirth__c: Date.new(1989, 1, 1),
      IsParentUnknown__c: false,
      RecordType: {}
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