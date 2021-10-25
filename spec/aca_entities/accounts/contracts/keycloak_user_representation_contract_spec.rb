# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Accounts::Contracts::KeycloakUserRepresentationContract do
  subject { described_class.new }

  let(:access) do
    {
      manage_group_membership: true,
      view: true,
      map_roles: true,
      impersonate: false,
      manage: true
    }
  end
  let(:attributes) { {} }
  let(:clientConsents) { [] }
  let(:clientRoles) { {} }
  let(:createdTimestamp) { 1 }
  let(:credentials) { [] }
  let(:disableableCredentialTypes) { [] }
  let(:email) { 'my_username@example.com' }
  let(:emailVerified) { false }
  let(:enabled) { true }
  let(:federatedIdentities) { [] }
  let(:federationLink) { [] }
  let(:firstName) { 'my_first_name' }
  let(:groups) { [] }
  let(:id) { '6304e375-c5f6-45c4-bd9c-da75b01d19f4' }
  let(:lastName) { 'my_last_name' }
  let(:notBefore) { 0 }
  let(:origin) { 'val_1' }
  let(:realmRoles) { [] }
  let(:requiredActions) { [] }

  # let(:self) { 'val_1' }
  let(:serviceAccountClientId) { 'val_1' }
  let(:username) { 'my_username' }

  let(:required_params) { {} }
  let(:optional_params) do
    {
      attributes: attributes,
      clientConsents: clientConsents,
      clientRoles: clientRoles,
      createdTimestamp: createdTimestamp,
      credentials: credentials,
      disableableCredentialTypes: disableableCredentialTypes,
      email: email,
      emailVerified: emailVerified,
      enabled: enabled,
      federatedIdentities: federatedIdentities,
      federationLink: federationLink,
      firstName: firstName,
      groups: groups,
      id: id,
      lastName: lastName,
      notBefore: notBefore,
      origin: origin,
      realmRoles: realmRoles,
      requiredActions: requiredActions,
      serviceAccountClientId: serviceAccountClientId,
      username: username
    }
    # self: self,
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
