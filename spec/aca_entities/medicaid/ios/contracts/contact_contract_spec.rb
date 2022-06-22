# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/ios'

RSpec.describe AcaEntities::Medicaid::Ios::Contracts::ContactContract, dbclean: :after_each do

  let(:required_params) do
    {
      FirstName: "First",
      LastName: "Last"
    }
  end

  let(:optional_params) do
    {
      AddressTypeCode__c: "Code",
      AgencyEmployeeId__c: "Id",
      AssociationStartDate__c: Date.today,
      Birthdate: 10.years.ago.to_date,
      Email: "fake@test.com",
      GenderCode__c: "M",
      MailingAddressLine2__c: "Address",
      OrganizationName__c: "Org",
      OrgranizationIdentificationNumber__c: "12345",
      PreferredLanguageCode__c: "EN",
      PrimaryPhoneExtension__c: 123,
      PrimaryPhoneNumber__c: "123-4567",
      RepresentativeProgramCode__c: "Medicaid",
      SSN__c: "123456789",
      SuffixCode__c: "n/a",
      IndividualId__c: "Id",
      Id: "Id",
      MiddleName: "",
      Phone: "123-4567",
      DCDataId__c: 12_345,
      IsManualAuthRep__c: false,
      RecordType: {},
      AgencyOrOrganization__r: {}
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