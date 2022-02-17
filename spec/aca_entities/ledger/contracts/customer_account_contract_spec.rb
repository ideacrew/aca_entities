# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Ledger::Contracts::CustomerAccountContract do
  subject { described_class.new }

  let(:id) { '12345' }
  let(:customer) { { person_name: { first_name: 'George', last_name: 'Jetson' }, hbx_id: '456654' } }
  let(:account) { { category: 'accounts_receivable', kind: 'accounts_receivable', is_active: true } }

  let(:exchange_assigned_id) { '68576' }
  let(:marketplace_segment_id) { '1138345-68576-20220201' }
  let(:rating_area_id) { 'R-ME001' }
  let(:start_on) { Date.new(2022, 2, 1) }

  let(:hbx_qhp_id) { '96667ME031005806' }
  let(:effective_year) { 2022 }
  let(:kind) { 'health' }
  let(:product) { { hbx_qhp_id: hbx_qhp_id, effective_year: effective_year, kind: kind } }

  let(:amount) { 875.22 }
  let(:insured_age) { 33 }
  let(:amount) { 875.22 }

  let(:premium) { { product: product, amount: amount, insured_age: insured_age } }
  let(:enrolled_members) { [{ member: customer, premium: premium, start_on: start_on }] }

  let(:policies) do
    [
      {
        exchange_assigned_id: exchange_assigned_id,
        marketplace_segment_id: marketplace_segment_id,
        product: product,
        rating_area_id: rating_area_id,
        start_on: start_on,
        enrolled_members: enrolled_members
      }
    ]
  end
  let(:is_active) { true }

  let(:moment) { DateTime.now }
  let(:timestamps) { { created_at: moment, modified_at: moment } }

  let(:required_params) { { customer: customer, account: account, policies: policies, is_active: is_active } }
  let(:optional_params) { { id: id, timestamps: timestamps } }

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
