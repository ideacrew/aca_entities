# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Accounts::Account do
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

  describe 'with valid arguments' do
    it 'validates input params with contract' do
      expect(
        AcaEntities::Accounts::Contracts::AccountContract
          .new
          .call(all_params)
          .success?
      ).to be_truthy
    end

    it 'should initialize' do
      expect(described_class.new(all_params.to_h)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(all_params.to_h) }.not_to raise_error
    end
  end
end
