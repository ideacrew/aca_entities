# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/ios'

RSpec.describe AcaEntities::Medicaid::Ios::Contracts::SspMemberRContract, dbclean: :after_each do

  let(:required_params) do
    { 
      IsFixedAddressToggle__c: 'Y',
      In_Which_City_Town_Applicant_Live__c: 'City',
      FirstName__c: 'First',
      LastName__c: 'Last',
      BirthDate__c: '01/01/2000',
      GenderCode__c: 'M',
      IsHispanicLatinoSpanishToggle__c: 'Y',
      IsIntendToResideToggle__c: 'Y'
    } 
  end

  let(:optional_params) do
    {
      PhysicalCity__c: 'City',
      PhysicalStateCode__c: 'CA',
      PhysicalZipCode5__c: '12345',
      PhysicalAddressLine2__c: 'Address',
      MiddleInitial__c: 'M',
      SuffixCode__c: 'S',
      RaceCode__c: 'R',
      NoReasonSSNCode__c: 'N',
      SSN__c: '123456789',
      IsMilitaryMemberToggle__c: 'Y',
      HasSSN__c: 'Y',
    }
  end

  let(:all_params) { required_params.merge(optional_params) }

  context 'invalid parameters' do
    context 'with incorrect data type' do
      it 'should list error for every parameter' do
        bad_params = { IndividualId__c: "bad data" }
        expect(subject.call(bad_params).errors.to_h.keys).to match_array required_params.keys
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