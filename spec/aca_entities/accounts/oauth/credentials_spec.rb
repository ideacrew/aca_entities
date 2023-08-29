# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Accounts::Oauth::Credentials do
  let(:token) { '48jdlllejjllklkfkklkdlfkfl' }
  let(:secret) { 'abd837sd989ddlsdlkdflkasd394887j' }
  let(:expires) { true }
  let(:expires_at) { Time.now }

  let(:required_params) { {} }
  let(:optional_params) { { token: token, secret: secret, expires: expires, expires_at: expires_at } }

  let(:all_params) { required_params.merge(optional_params) }

  context 'Calling the contract with only optional params' do
    subject { described_class.call(optional_params) }

    it 'should pass validation' do
      expect(subject).to be_a described_class
      expect(subject.to_h).to eq optional_params
    end
  end

  context 'Calling the contract with all params' do
    subject { described_class.call(all_params) }

    it 'should pass validation' do
      expect(subject).to be_a described_class
      expect(subject.to_h).to eq all_params
    end
  end
end
