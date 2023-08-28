# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Accounts::Oauth::Omniauth do
  subject { described_class.new }

  let(:provider) { 'keycloak_openid' }
  let(:uid) { '6304e375-c5f6-45c4-bd9c-da75b01d19f4' }
  let(:name) { 'george jetson' }
  let(:email) { 'george.jetson2022@example.com' }
  let(:info) { { name: name, email: email } }

  let(:moment) { DateTime.now }
  let(:time_stamp) { { submitted_at: moment, created_at: moment, modified_at: moment } }

  let(:required_params) { { provider: provider, uid: uid, info: info } }
  let(:optional_params) { { time_stamp: time_stamp } }
  let(:all_params) { required_params.merge(optional_params) }

  context 'Calling the contract with only optional params' do
    it 'should fail validation' do
      expect { described_class.call(optional_params) }.to raise_error(Dry::Struct::Error)
    end
  end

  context 'Calling the contract with required params' do
    it 'should pass validation' do
      result = described_class.call(required_params)
      expect(result).to be_a AcaEntities::Accounts::Oauth::Omniauth
      expect(result.to_h).to eq required_params
    end
  end

  context 'Calling the contract with all params' do
    it 'should pass validation' do
      result = described_class.call(all_params)

      expect(result).to be_a AcaEntities::Accounts::Oauth::Omniauth
      expect(result.to_h).to eq all_params
    end
  end
end
