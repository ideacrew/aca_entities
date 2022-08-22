# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/eligibilities/eligibilities_shared_context'

RSpec.describe AcaEntities::Eligibilities::Contracts::GrantContract do
  include_context 'eligibilities_shared_context'
  subject { described_class.new }

  let(:key) { 'AdvancePremiumAdjustmentGrant' }
  let(:description) { 'APTC Grant' }
  let(:value) { 100.00 }
  let(:start_on) { five_days_from_today }
  let(:end_on) { Date.today.next_month }

  let(:required_params) do
    {
      title: 'APTC Grant',
      key: key,
      value: value,
      start_on: start_on,
      end_on: end_on
    }
  end
  let(:optional_params) do
    {
      description: description
    }
  end

  let(:all_params) { required_params.merge(optional_params) }

  context 'Calling the contract with no params' do
    let(:error_message) do
      { start_on: ['is missing'], value: ['is missing'], key: ['is missing'], title: ['is missing'] }
    end

    it 'should fail validation' do
      result = described_class.new.call({})

      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
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