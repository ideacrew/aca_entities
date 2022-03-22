# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Ledger::Contracts::PolicyContract do
  subject { described_class.new }

  let(:id) { '12345' }

  let(:insurer) { { name: 'Harvard Pilgrim Health Care', hios_id: '96667' } }
  let(:exchange_assigned_id) { '68576' }
  let(:insurer_assigned_id) { 'HP5992049' }
  let(:marketplace_segment_id) { '1138345-68576-20220201' }

  let(:hbx_qhp_id) { '96667ME031005806' }
  let(:effective_year) { 2022 }
  let(:kind) { 'health' }
  let(:product) { { hbx_qhp_id: hbx_qhp_id, effective_year: effective_year, kind: kind } }

  let(:subscriber_hbx_id) { '1138345' }
  let(:policy_id) { '68576' }
  let(:start_on) { Date.new(2022, 1, 1) }
  let(:end_on) { Date.new(2022, 12, 31) }
  let(:segment) { [subscriber_hbx_id, policy_id, start_on.strftime('%Y%m%d')].join('-') }

  let(:hbx_id) { subscriber_hbx_id }
  let(:person_name) { { first_name: 'George', last_name: 'Jetson' } }
  let(:dob) { Date.new(1982, 6, 1) }
  let(:insured_age) { 33 }
  let(:amount) { 875.22 }
  let(:premium) { { insured_age: insured_age, amount: amount } }

  let(:enrolled_member) do
    {
      member: {
        hbx_id: hbx_id,
        subscriber_hbx_id: subscriber_hbx_id,
        person_name: person_name,
        dob: dob
      },
      premium: premium,
      start_on: start_on
    }
  end
  let(:enrolled_members) { [enrolled_member] }
  let(:marketplace_segment) do
    {
      subscriber_hbx_id: subscriber_hbx_id,
      start_on: start_on,
      segment: segment,
      enrolled_members: enrolled_members,
      total_premium_amount: amount,
      total_premium_responsibility_amount: amount
    }
  end

  let(:marketplace_segments) { [marketplace_segment] }

  let(:service_area_id) { 'ME001' }
  let(:rating_area_id) { 'R-ME001' }
  let(:start_on) { Date.new(2022, 2, 1) }
  let(:end_on) { Date.new(2022, 2, 28) }

  let(:moment) { DateTime.now }
  let(:timestamps) { { created_at: moment, modified_at: moment } }

  let(:required_params) do
    {
      insurer: insurer,
      product: product,
      marketplace_segments: marketplace_segments,
      exchange_assigned_id: exchange_assigned_id,
      subscriber_hbx_id: subscriber_hbx_id,
      rating_area_id: rating_area_id,
      start_on: start_on
    }
  end

  let(:optional_params) do
    {
      id: id,
      insurer_assigned_id: insurer_assigned_id,
      service_area_id: service_area_id,
      end_on: end_on,
      timestamps: timestamps
    }
  end

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
        exchange_assigned_id: ['is missing'],
        product: ['is missing'],
        insurer: ['is missing'],
        marketplace_segments: ['is missing'],
        rating_area_id: ['is missing'],
        start_on: ['is missing'],
        subscriber_hbx_id: ['is missing']
      }
    end
    it 'should pass validation' do
      result = subject.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end
end
