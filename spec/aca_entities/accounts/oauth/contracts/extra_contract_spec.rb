# frozen_string_literal: true

require 'spec_helper'
require_relative "../support/shared_examples/keycloak_oidc_examples"

RSpec.describe AcaEntities::Accounts::Oauth::Contracts::ExtraContract do
  subject { described_class.new }
  include_context 'keycloak oidc examples'

  let(:raw_info) { auth_response['extra']['raw_info'] }

  let(:required_params) { {} }
  let(:optional_params) { { raw_info: raw_info } }
  let(:all_params) { required_params.merge(optional_params) }

  context 'Calling the contract with only optional params' do
    subject { described_class.new.call(optional_params) }

    it 'should pass validation' do
      expect(subject.success?).to be_truthy
    end
  end

  context 'Calling the contract with required params' do
    subject { described_class.new.call(required_params) }

    it 'should pass validation' do
      expect(subject.success?).to be_truthy
    end

    it 'all input params should have matchig attribute' do
      expect(subject.to_h).to eq required_params
    end
  end

  context 'Calling the contract with all params' do
    subject { described_class.new.call(all_params) }

    it 'should pass validation' do
      expect(subject.success?).to be_truthy
    end

    it 'all input params should have matchig attribute' do
      expect(subject.to_h).to eq all_params
    end
  end
end
