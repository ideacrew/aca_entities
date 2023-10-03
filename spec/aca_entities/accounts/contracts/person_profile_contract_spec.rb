# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Accounts::Contracts::PersonProfileContract do
  subject(:person_profile) { described_class.new }

  let(:client_key) { 'polypress' }

  let(:preferred_name) { 'John Jacob Jingleheimer-Schmitt' }
  let(:locale) { 'en' }
  let(:notice_delivery_method) { 'electronic_preferred' }
  let(:electronic_communication_method) { 'sms' }
  let(:email) { 'jjj@folksongs.org' }
  let(:mobile_phone) { '2025551212' }
  let(:created_at) { Time.now }
  let(:updated_at) { created_at }

  let(:required_params) do
    {
      preferred_name: preferred_name,
      locale: locale,
      notice_delivery_method: notice_delivery_method,
      electronic_communication_method: electronic_communication_method
    }
  end
  let(:optional_params) { { email: email, mobile_phone: mobile_phone, created_at: created_at, updated_at: updated_at } }

  let(:all_params) { required_params.merge(optional_params) }

  context 'Calling the contract with required params' do
    it 'parameters are valid' do
      expect(person_profile.call(required_params).success?).to be_truthy
    end

    it 'validated attributes match passed parameters' do
      expect(person_profile.call(required_params).to_h).to eq required_params
    end
  end

  context 'Calling the contract with only optional params' do
    let(:missing_params_error_hash) do
      {
        electronic_communication_method: ['is missing'],
        preferred_name: ['is missing'],
        notice_delivery_method: ['is missing']
      }
    end
    it 'parameters are invalid' do
      expect(person_profile.call(optional_params).failure?).to be_truthy
    end

    it 'returned errors specify missing required parameters' do
      expect(person_profile.call(optional_params).errors.to_h).to eq missing_params_error_hash
    end
  end

  context 'Calling the contract with all params' do
    it 'parameters are valid' do
      expect(person_profile.call(all_params).success?).to be_truthy
    end

    it 'validated attributes match passed parameters' do
      expect(person_profile.call(all_params).to_h).to eq all_params
    end
  end
end
