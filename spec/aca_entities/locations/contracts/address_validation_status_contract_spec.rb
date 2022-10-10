# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Locations::Contracts::AddressValidationStatusContract do
  subject { described_class.new }

  let(:id) { '12345' }
  let(:authority) { 'SmartyStreets' }
  let(:validated_on) { moment }
  let(:payload) { nil }

  let(:moment) { DateTime.now }
  let(:timestamps) { { created_at: moment, modified_at: moment } }

  let(:required_params) { { authority: authority, validated_on: validated_on } }
  let(:optional_params) { { payload: payload, timestamps: timestamps } }

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
    let(:error_message) { { authority: ['is missing'], validated_on: ['is missing'] } }

    it 'should pass validation' do
      result = subject.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end
end
