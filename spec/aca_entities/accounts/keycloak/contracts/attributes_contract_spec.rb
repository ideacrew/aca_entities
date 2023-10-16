# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Accounts::Keycloak::Contracts::AttributesContract do
  subject { described_class.new }

  let(:id) { '6304e375-c5f6-45c4-bd9c-da75b01d19f4' }
  let(:relay_state) { '/exchanges/hbx_profiles' }

  let(:created_at) { DateTime.now }
  let(:updated_at) { created_at }

  let(:required_params) { {} }
  let(:optional_params) { { id: id, relay_state: relay_state, created_at: created_at, updated_at: updated_at } }

  let(:all_params) { required_params.merge(optional_params) }

  context 'Calling the contract with optional params' do
    it 'should pass validation' do
      result = subject.call(optional_params)
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

  context 'when passed invalid relay state' do
    let(:invalid_relay_state) { 'profiles/registrations/new' }

    it 'should fail' do
      result = subject.call(all_params.merge(relay_state: invalid_relay_state))
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to include(:relay_state)
    end
  end

  context 'when passed valid relay state that includes identifier' do
    let(:relay_state_with_id) { "#{relay_state}/%23%5BDouble%20(anonymous)%5D" }

    it 'should pass' do
      result = described_class.new.call(all_params.merge(relay_state: relay_state_with_id))
      expect(result.success?).to be_truthy
      expect(result.to_h).to eq all_params.merge(relay_state: relay_state_with_id)
    end
  end
end
