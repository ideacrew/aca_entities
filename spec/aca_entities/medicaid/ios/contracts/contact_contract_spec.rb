# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/ios'

RSpec.describe AcaEntities::Medicaid::Ios::Contracts::ContactContract do

  let(:required_params) do
    {
      FirstName: "First",
      LastName: "Last"
    }
  end

  let(:optional_params) do
    {
      AssociationStartDate__c: Date.today,
      Birthdate: Date.new(1990, 1, 1),
      Email: "fake@test.com",
      GenderCode__c: "M",
      MailingAddressLine2__c: "Address",
      PreferredLanguageCode__c: "EN",
      PrimaryPhoneExtension__c: 123,
      PrimaryPhoneNumber__c: "123-4567",
      SSN__c: "123456789",
      SuffixCode__c: "n/a",
      Id: "Id",
      MiddleName: "M",
      Phone: "123-4567"
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
      it 'should list fail validation' do
        all_params[:MailingAddressLine2__c] = "Address!"
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
