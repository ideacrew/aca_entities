# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::InsurancePolicies::Contracts::PremiumScheduleContract do
  subject { described_class.new }

  let(:moment) { DateTime.now }
  let(:id) { '12345' }

  # let(:insurance_policy) { {  } }
  let(:premium_amount) { 345.66 }
  let(:insured_start_on) { Date.new(moment.year, 1, 1) }
  let(:insured_end_on) { Date.new(moment.year, 3, 1) }
  let(:valid_start_on) { Date.new(moment.year, 1, 1) }
  let(:valid_end_on) { Date.new(moment.year, 12, 31) }
  let(:due_on) { Date.new(moment.year, 1, 31) }

  # let(:period_type) { {} }
  let(:timestamps) { { created_at: moment, modified_at: moment } }

  let(:required_params) do
    {
      premium_amount: premium_amount,
      insured_start_on: insured_start_on,
      insured_end_on: insured_end_on,
      valid_start_on: valid_start_on,
      valid_end_on: valid_end_on
    }
  end
  let(:optional_params) { { id: id, due_on: due_on, timestamps: timestamps } }

  let(:all_params) { required_params.merge(optional_params) }

  context 'Calling contract with Valid params' do
    context 'Calling the contract with required params' do
      it 'should pass validation' do
        result = subject.call(required_params)
        expect(result.success?).to be_truthy
        expect(result.to_h).to eq required_params
      end
    end

    context 'Calling the contract with all params' do
      it 'should pass validation' do
        result = subject.call(all_params)
        expect(result.success?).to be_truthy
        expect(result.to_h).to eq all_params
      end
    end
  end

  context 'Calling the contract with no params' do
    let(:error_message) do
      {
        premium_amount: ['is missing'],
        insured_start_on: ['is missing'],
        insured_end_on: ['is missing'],
        valid_start_on: ['is missing'],
        valid_end_on: ['is missing']
      }
    end
    it 'should pass validation' do
      result = subject.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end
end
