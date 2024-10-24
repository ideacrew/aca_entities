# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::InsurancePolicies::Contracts::InsuranceProductFeatureContract do
  subject { described_class.new }

  let(:moment) { DateTime.now }
  let(:id) { '12345' }

  let(:key) { 'pediatric_dental' }
  let(:title) { 'Pediatric Dental Coverage' }
  let(:description) { 'Plan includes dental essential benefits for all enrollees under age 19' }
  let(:value) { 100.00 }
  let(:timestamps) { { created_at: moment, modified_at: moment } }

  let(:required_params) { { key: key, title: title } }
  let(:optional_params) { { id: id, description: description, value: value, timestamps: timestamps } }

  let(:all_params) { required_params.merge(optional_params) }

  context 'Calling contract with Valid params' do
    context 'Calling the contract with required params' do
      it 'should pass validation' do
        result = subject.call(required_params)
        expect(result.success?).to be_truthy
        expect(result.to_h).to eq required_params
      end
    end

    context 'Calling the contract with all params' do
      it 'should pass validation' do
        result = subject.call(all_params)
        expect(result.success?).to be_truthy
        expect(result.to_h).to eq all_params
      end
    end
  end

  context 'Calling the contract with no params' do
    let(:error_message) { { key: ['is missing'], title: ['is missing'] } }
    it 'should pass validation' do
      result = subject.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end
end
