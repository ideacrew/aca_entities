# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Identities::Contracts::UserProfileContract do
  subject { described_class.new }

  let(:client_key) { 'polypress' }
  let(:locale) { 'en' }
  let(:communication_preference) { 'electronic_preferred' }
  let(:electronic_communication_method) { 'sms' }

  let(:required_params) { {} }
  let(:optional_params) do
    {
      client_key: client_key,
      settings: {
        locale: locale,
        communication_preference: communication_preference,
        electronic_communication_method: electronic_communication_method
      }
    }
  end

  let(:all_params) { required_params.merge(optional_params) }

  context 'Calling the contract with optional params' do
    it 'should pass validation' do
      result = described_class.new.call(optional_params)
      expect(result.success?).to be_truthy
    end
  end

  context 'Calling the contract with required params' do
    it 'should pass validation' do
      result = described_class.new.call(required_params)
      expect(result.success?).to be_truthy
      expect(result.to_h).to eq required_params
    end
  end

  context 'Calling the contract with all params' do
    it 'should pass validation' do
      result = described_class.new.call(all_params)
      expect(result.success?).to be_truthy
      expect(result.to_h).to eq all_params
    end
  end
end
