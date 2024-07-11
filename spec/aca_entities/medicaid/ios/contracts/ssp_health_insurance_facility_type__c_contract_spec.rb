# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/ios'

RSpec.describe AcaEntities::Medicaid::Ios::Contracts::SspHealthInsuranceFacilityTypeCContract do

  let(:required_params) do
    {
      CoverageStartDate__c: Date.today - 1
    }
  end

  let(:optional_params) do
    {
      SSP_InsuranceCoveredIndiv__c: "Insurance Coverd Indiv",
      Id: "12345",
      CoverageEndDate__c: Date.today,
      FacilityType__c: "Facility Type"  # SelectAtLeast1Validator <- validate in transform
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

    context 'invalid coverage end date' do
      context 'with coverage end date earlier than coverage start date' do
        it 'should fail validation' do
          all_params[:CoverageEndDate__c] = Date.today - 2
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
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
