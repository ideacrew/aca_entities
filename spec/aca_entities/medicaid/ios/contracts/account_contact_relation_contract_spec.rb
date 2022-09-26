# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/ios'

RSpec.describe AcaEntities::Medicaid::Ios::Contracts::AccountContactRelationContract, dbclean: :after_each do

  let(:required_params) do
    {
      AddressLine1__c: "123 Main",
      City__c: "Atlantis",
      StateCode__c: "CA",
      Contact: contact
    }
  end

  let(:contact) do
    {
      FirstName: "First",
      LastName: "Last"
    }
  end

  let(:optional_params) do
    {
      DCRepresentativeId__c: 1234,
      DCContactId__c: 2345,
      DCAgencyId__c: 3456,
      DCDataId__c: 4567,
      IsRepresentativeVerified__c: "false",
      AddressLine2__c: "Apt. 123",
      Street__c: "Sesame St",
      Zipcode5__c: "11111",
      Zipcode4__c: "2222",
      CountyCode__c: "Aroostook",
      IsAddressValidated__c: false,
      ContactId: "Id",
      Id: "Id",
      Roles: "Role",
      ProgramsApplied__c: "Medicaid",
      PermissionLevel_Medicaid__c: "Level 1",
      PermissionLevel_SNAP__c: "Level 1",
      PermissionLevel_StateSupp__c: "Level 1",
      PermissionLevel_KIHIPP__c: "Level 1",
      PermissionLevel_KTAP__c: "Level 1",
      PermissionLevel_CCAP__c: "Level 1",
      StartDate: Date.today,
      RepresentativeRelationshipCode__c: "Code"
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

    context 'with invalid address line 2 characters' do
      it 'should fail validation' do
        all_params[:AddressLine2__c] = "Address!"
        result = subject.call(all_params)
        expect(result.success?).to be_falsey
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