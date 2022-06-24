# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/ios'

RSpec.describe AcaEntities::Medicaid::Ios::Contracts::SspInsuranceCoveredIndivCContract, dbclean: :after_each do

  let(:all_params) do
    {
      DateofBirth__c: Date.today,
      DCId__c: 12_345,
      DCIndividualId__c: 12_345,
      DCMedicaidPolicyIndividualId__c: 12_345,
      ExtAddressLine1__c: "123 Main St",
      ExtAddressLine2__c: "Apt 1",
      ExtCity__c: "Sim City",
      ExtPolicyHolderFirstName__c: "Ex",
      ExtPolicyHolderLastName__c: "PolicyHolder",
      ExtPolicyHolderMiddleInitial__c: "T",  # MaxStringLengthValidator(30)
      ExtPolicyHolderSsn__c: 123_456_789,
      ExtStateCode__c: "State",
      ExtZipCode4__c: "1234",
      ExtZipCode5__c: "12345",
      FirstName__c: "First",
      Gender__c: "F",
      IsEnrolled__c: true,  # SelectAtLeast1CoverageEnrollmentValidator
      IsTobbacoConsumerToggle__c: "N",
      LastName__c: "Last",
      MedicaidId__c: "Medicaid Id",
      RelationshipCode__c: "Relationship",
      SSN__c: "123456789",
      SSP_Member__c: "Member",
      SuffixCode__c: "Suffix",
      IndividualId__c: 12_345,
      SSP_InsurancePolicy__c: "Insurance Policy",
      IsDeleted__c: false,
      IsInsuranceCovered__c: "Y",
      IsPolicyHolder__c: true,
      InsuranceInternalPolicyHolder__c: "Insurance Internal Policy Holder",
      Id: "Id",
      RecordType: {},
      SSP_Member__r: {}
    }
  end

  context 'invalid parameters' do
    context 'with incorrect data type' do
      it 'should list error for every bad parameter' do
        bad_params = { DateofBirth__c: 0 }
        expect(subject.call(bad_params).errors.to_h.keys).to match_array bad_params.keys
      end
    end

    # add examples to test validation rules
    # context 'invalid ext policy holder middle initial' do
    #   context 'with middle initial longer than 30 characters' do
    #     it 'should fail validation' do
    #       all_params[:ExtPolicyHolderMiddleInitial__c] = "ExtPolicyHolderMiddleInitial__c longer than 30 chars"
    #       result = subject.call(all_params)
    #       expect(result.success?).to be_falsey
    #     end
    #   end
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