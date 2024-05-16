# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Accounts::Oauth::OpenidConnect::Contracts::IdTokenContract do
  # identity provider

  # identifier for the issuer of the response
  let(:iss) { 'http://0.0.0.0:8180/realms/ideacrew' }

  # the unique account ID
  let(:sub) { '8323557f-4430-4a9a-81e9-da3aab221ede' }

  # the client application
  let(:aud) { 'sbm-service' }
  let(:exp) { 1_713_978_315 }
  let(:iat) { 1_713_978_015 }

  let(:acr) { '0' }
  # authentication method reference - how the user authenticated
  let(:amr) { ['pwd'] } # (they used a password)
  let(:azp) { 'sbm-service' }
  let(:jti) { 'f9165c53-f7ea-408b-94a3-6bd2bc39045b' }
  # the session ID
  let(:sid) { 'c120371f-ce6d-4a9d-bb51-9bc9d3125dd6' }

  # the time the user last authenticated
  let(:auth_time) { 1_713_978_015 }
  # the no more than once (detects id token injection)
  let(:nonce) { 'f113c399cfe39175b30cc2e8e1b4d45a' }

  let(:sub_jwk) { 'sub_jwk' }
  # a hash of the access token (detects access token injection)
  let(:at_hash) { 'QgzWsxjz1fGpPWZuQgz5Cw' }
  let(:c_hash) { 'c_hash' }
  let(:s_hash) { 's_hash' }

  let(:name) { 'George Jetson' }
  let(:preferred_username) { 'gorgous_george' }
  let(:given_name) { 'George' }
  let(:family_name) { 'Jetson' }
  let(:email) { 'george.jetson@example.com' }
  let(:email_verified) { true }
  let(:typ) { 'ID' }
  let(:session_state) { 'c120371f-ce6d-4a9d-bb51-9bc9d3125dd6' }

  let(:required_params) { { iss: iss, sub: sub, aud: aud, exp: exp, iat: iat } }
  let(:optional_params) do
    {
      acr: acr,
      amr: amr,
      azp: azp,
      jti: jti,
      sid: sid,
      auth_time: auth_time,
      nonce: nonce,
      sub_jwk: sub_jwk,
      at_hash: at_hash,
      c_hash: c_hash,
      s_hash: s_hash
    }
  end

  let(:all_params) { required_params.merge(optional_params) }

  context 'Calling the contract with only optional params' do
    subject { described_class.new.call(optional_params) }

    it 'should fail validation' do
      expect(subject.failure?).to be_truthy
    end
  end

  context 'Calling the contract with required params' do
    subject { described_class.new.call(required_params) }

    it 'should pass validation' do
      expect(subject.success?).to be_truthy
    end

    it 'all input params should have matching attribute' do
      expect(subject.to_h).to eq required_params
    end
  end

  context 'Calling the contract with all params' do
    subject { described_class.new.call(all_params) }

    it 'should pass validation' do
      expect(subject.success?).to be_truthy
    end

    it 'all input params should have matching attribute' do
      expect(subject.to_h).to eq all_params
    end
  end
end
