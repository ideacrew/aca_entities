# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Accounts::Contracts::AccountContract do
  subject { described_class.new }

  let(:id) { '6304e375-c5f6-45c4-bd9c-da75b01d19f4' }
  let(:username) { 'my_username' }
  let(:email) { 'my_username@example.com' }
  let(:first_name) { 'my_first_name' }
  let(:last_name) { 'my_last_name' }
  let(:password) { '$3cr3tP@55w0rd' }

  let(:enabled) { true }
  let(:totp) { true }
  let(:email_verified) { false }
  let(:not_before) { 0 }
  let(:access) do
    {
      manage_group_membership: true,
      view: true,
      map_roles: true,
      impersonate: false,
      manage: true
    }
  end
  let(:groups) { [] }
  let(:roles) { [] }
  let(:created_at) { DateTime.now }

  let(:required_params) { { username: username } }
  let(:optional_params) do
    {
      id: id,
      email: email,
      first_name: first_name,
      last_name: last_name,
      password: password,
      enabled: enabled,
      totp: totp,
      email_verified: email_verified,
      not_before: not_before,
      roles: roles,
      access: access,
      groups: groups,
      created_at: created_at
    }
  end

  let(:all_params) { required_params.merge(optional_params) }

  context 'Calling the contract with optional params' do
    it 'should fail validation' do
      result = described_class.new.call(optional_params)
      expect(result.failure?).to be_truthy
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
