# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Ledger::Contracts::CustomerAccountContract do
  subject { described_class.new }

  let(:id) { '12345' }
  let(:customer) { { person_name: { first_name: 'George', last_name: 'Jetson' }, hbx_id: '456654' } }
  let(:account) { { category: 'accounts_receivable', kind: 'accounts_receivable', is_active: true } }

  let(:exchange_assigned_id) { '68576' }
  let(:rating_area_id) { 'R-ME001' }
  let(:start_on) { Date.new(2022, 2, 1) }

  let(:subscriber_hbx_id) { '1138345' }
  let(:policy_id) { '68576' }
  let(:segment) { [subscriber_hbx_id, policy_id, start_on.strftime('%Y%m%d')].join('-') }

  let(:hbx_id) { subscriber_hbx_id }
  let(:person_name) { { first_name: 'George', last_name: 'Jetson' } }
  let(:insured_age) { 33 }
  let(:amount) { 875.22 }
  let(:premium) { { insured_age: insured_age, amount: amount } }

  let(:member) { { member: { hbx_id: hbx_id, person_name: person_name }, premium: premium, start_on: start_on } }
  let(:enrolled_members) { [member] }
  let(:marketplace_segment) do
    {
      subscriber_hbx_id: subscriber_hbx_id,
      policy_id: policy_id,
      start_on: start_on,
      segment: segment,
      enrolled_members: enrolled_members
    }
  end

  let(:marketplace_segments) { [marketplace_segment] }

  let(:hios_id) { '96667' }
  let(:insurer) { { hios_id: hios_id } }
  let(:hbx_qhp_id) { '96667ME031005806' }
  let(:effective_year) { 2022 }
  let(:kind) { 'health' }
  let(:product) { { hbx_qhp_id: hbx_qhp_id, effective_year: effective_year, kind: kind } }
  let(:policies) do
    [
      {
        exchange_assigned_id: exchange_assigned_id,
        marketplace_segments: marketplace_segments,
        subscriber_hbx_id: subscriber_hbx_id,
        insurer: insurer,
        product: product,
        rating_area_id: rating_area_id,
        start_on: start_on
      }
    ]
  end
  let(:amount) { 875.22 }
  let(:insured_age) { 33 }
  let(:amount) { 875.22 }

  let(:premium) { { amount: amount, insured_age: insured_age } }
  let(:enrolled_members) { [{ member: customer, premium: premium, start_on: start_on }] }

  let(:tax_household) { { aptc_amount_total: 585.69 } }
  let(:tax_households) { [tax_household] }

  let(:is_active) { true }

  let(:moment) { DateTime.now }
  let(:timestamps) { { created_at: moment, modified_at: moment } }

  let(:required_params) { { customer: customer, account: account, policies: policies, is_active: is_active } }
  let(:optional_params) { { id: id, tax_households: tax_households, timestamps: timestamps } }

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
      { account: ['is missing'], customer: ['is missing'], is_active: ['is missing'], policies: ['is missing'] }
    end
    it 'should pass validation' do
      result = subject.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end
end
