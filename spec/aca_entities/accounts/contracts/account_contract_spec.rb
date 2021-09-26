# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Accounts::Contracts::AccountContract do
  subject { described_class.new }

  let(:username) { 'my_username' }
  let(:email) { 'my_username@example.com' }
  let(:first_name) { 'my_first_name' }
  let(:last_name) { 'my_last_name' }
  let(:password) { '$3cr3tP@55w0rd' }

  let(:created_at) { DateTime.now }
  let(:submitted_at) { created_at }
  let(:modified_at) { created_at }
  let(:timestamps) do
    {
      created_at: created_at,
      submitted_at: submitted_at,
      modified_at: modified_at
    }
  end

  let(:required_params) { {} }
  let(:optional_params) do
    {
      username: username,
      email: email,
      first_name: first_name,
      last_name: last_name,
      password: password,
      timestamps: timestamps
    }
  end
  let(:all_params) { required_params.merge(optional_params) }

  context 'Calling the contract with optional params' do
    it 'should pass validation' do
      result = described_class.new.call(optional_params)
      expect(result.success?).to be_truthy
      expect(result.to_h).to eq optional_params
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
