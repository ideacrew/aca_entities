# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/ios'

RSpec.describe AcaEntities::Medicaid::Ios::Contracts::SspInsurancePolicyCContract, dbclean: :after_each do

  let(:required_params) do
    {
      Is_this_an_empl__c: "N",
      IsEnrolledInInsurance__c: true
    }
  end

  let(:optional_params) do
    {
      DCId__c: 12_345,
      InsuranceCompanyName__c: "Insurance Co",
      InsuranceGroupNumber__c: "Group 123",
      InsurancePolicyNumber__c: "Policy 123",
      PhysicalAddressLine1__c: "123 Main St",
      PhysicalAddressLine2__c: "Apt 1",
      PhysicalCity__c: "Atlantis",
      PhysicalCountryCode__c: "USA",
      PhysicalStateCode__c: "ME",
      PhysicalZipCode4__c: "1234",
      PhysicalZipCode5__c: "12345",
      PlanName__c: "Plan Name",
      PolicyBeginDate__c: Date.today,
      TypeOfCoverageCode__c: "Coverage Code",
      IndividualId__c: 12_345,
      EnrollmentTierLevel__c: "Tier Level",
      IsPolicyUpdated__c: false,
      Id: "Id",
      IsDeleted__c: false,
      DCEmploymentDetailId__c: 12_345,
      EmployerName__c: "Employer Name",
      IsHealthCareCovPolicyHolderOutSideCase__c: false
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