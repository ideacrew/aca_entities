# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Accounts::Keycloak::Contracts::CredentialsContract do
  subject { described_class.new }

  let(:algorithm) { 'aes' }
  let(:config) { {} }
  let(:counter) { 0 }
  let(:createdDate) { 32_764 }
  let(:device) { 'my_device' }
  let(:digits) { 17 }
  let(:hashIterations) { 1 }
  let(:hashedSaltedValue) { 'XYZ321' }
  let(:period) { 31 }
  let(:salt) { 'ABC123' }
  let(:temporary) { false }
  let(:type) { 'password' }
  let(:value) { '$3cr3tP@55w0rd' }

  let(:required_params) { {} }
  let(:optional_params) do
    {
      algorithm: algorithm,
      config: config,
      counter: counter,
      createdDate: createdDate,
      device: device,
      digits: digits,
      hashIterations: hashIterations,
      hashedSaltedValue: hashedSaltedValue,
      period: period,
      salt: salt,
      temporary: temporary,
      type: type,
      value: value
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
