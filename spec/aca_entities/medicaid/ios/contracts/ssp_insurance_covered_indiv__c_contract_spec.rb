# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/ios'

RSpec.describe AcaEntities::Medicaid::Ios::Contracts::SspInsuranceCoveredIndivCContract, dbclean: :after_each do

  let(:all_params) do
    {
      DateofBirth__c: Date.today,
      FirstName__c: "First",
      Gender__c: "F",
      IsEnrolled__c: true,  # SelectAtLeast1CoverageEnrollmentValidator
      IsTobbacoConsumerToggle__c: "N",
      LastName__c: "Last",
      SSN__c: "123456789",
      SSP_Member__c: "Member",
      SuffixCode__c: "Suffix",
      SSP_InsurancePolicy__c: "Insurance Policy",
      IsInsuranceCovered__c: "Y",
      IsPolicyHolder__c: true,
      InsuranceInternalPolicyHolder__c: "Insurance Internal Policy Holder",
      Id: "Id"
    }
  end

  context 'invalid parameters' do
    context 'with incorrect data type' do
      it 'should list error for every bad parameter' do
        bad_params = { DateofBirth__c: 0 }
        expect(subject.call(bad_params).errors.to_h.keys).to match_array bad_params.keys
      end
    end
  end

  context 'valid parameters' do
    context 'with all required and optional parameters' do
      it 'should pass validation' do
        result = subject.call(all_params)
        expect(result.success?).to be_truthy
        expect(result.to_h).to eq all_params
      end
    end
  end
end