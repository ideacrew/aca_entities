# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Identities::Contracts::IdentityContract do
  subject { described_class.new }

  let(:id) { '6304e375-c5f6-45c4-bd9c-da75b01d19f4' }
  let(:name) { 'George Jetson' }
  let(:enabled) { true }

  let(:moment) { DateTime.now }
  let(:time_stamp) { { submitted_at: moment, created_at: moment, modified_at: moment } }

  let(:required_params) { { name: name, enabled: enabled } }
  let(:optional_params) { { id: id, time_stamp: time_stamp } }
  let(:all_params) { required_params.merge(optional_params) }

  context 'Calling the contract with only optional params' do
    it 'should fail validation' do
      result = described_class.call(optional_params)
      expect(result.failure?).to be_truthy
    end
  end

  context 'Calling the contract with required params' do
    it 'should pass validation' do
      result = described_class.call(required_params)

      expect(result.success?).to be_truthy
      expect(result.to_h).to eq required_params
    end
  end

  context 'Calling the contract with all params' do
    it 'should pass validation' do
      result = described_class.call(all_params)

      expect(result.success?).to be_truthy
      expect(result.to_h).to eq all_params
    end
  end
end
