# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Ledger::Contracts::MarketplaceSegmentContract do
  subject { described_class.new }

  let(:id) { '12345' }
  let(:subscriber_hbx_id) { '1138345' }
  let(:policy_id) { '68576' }
  let(:start_on) { Date.new(2022, 1, 1) }
  let(:end_on) { Date.new(2022, 12, 31) }
  let(:segment) { [subscriber_hbx_id, policy_id, start_on.strftime('%Y%m%d')].join('-') }

  let(:total_premium_amount) { 1174.0 }
  let(:total_premium_responsibility_amount) { 588.0 }

  let(:hbx_id) { subscriber_hbx_id }
  let(:person_name) { { first_name: 'George', last_name: 'Jetson' } }
  let(:insured_age) { 33 }
  let(:amount) { 875.22 }
  let(:premium) { { insured_age: insured_age, amount: amount } }

  let(:member) do
    {
      member: {
        hbx_id: hbx_id,
        subscriber_hbx_id: subscriber_hbx_id,
        person_name: person_name
      },
      premium: premium,
      start_on: start_on
    }
  end
  let(:enrolled_members) { [member] }

  let(:moment) { DateTime.now }
  let(:timestamps) { { created_at: moment, modified_at: moment } }

  let(:required_params) do
    {
      total_premium_amount: total_premium_amount,
      total_premium_responsibility_amount: total_premium_responsibility_amount,
      start_on: start_on,
      segment: segment,
      enrolled_members: enrolled_members
    }
  end
  let(:optional_params) { { id: id, subscriber_hbx_id: subscriber_hbx_id, end_on: end_on, timestamps: timestamps } }

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
        enrolled_members: ['is missing'],
        segment: ['is missing'],
        start_on: ['is missing'],
        total_premium_amount: ['is missing'],
        total_premium_responsibility_amount: ['is missing']
      }
    end
    it 'should pass validation' do
      result = subject.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end
end
