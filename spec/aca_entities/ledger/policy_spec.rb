# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Ledger::Policy do
  subject { described_class }

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
  let(:insured_age) { 33 }
  let(:amount) { 875.22 }
  let(:premium) { { insured_age: insured_age, amount: amount } }

  let(:enrolled_member) do
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
  let(:enrolled_members) { [enrolled_member] }
  let(:marketplace_segment) do
    {
      subscriber_hbx_id: subscriber_hbx_id,
      start_on: start_on,
      segment: segment,
      enrolled_members: enrolled_members,
      total_policy_amount: amount,
      total_policy_responsibility_amount: amount
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

  describe 'with required arguments' do
    it 'should initialize' do
      expect(subject.new(required_params)).to be_a described_class
    end
  end

  describe 'Applying Comparable methods' do
    context 'and comparing two policies with same attributes' do
      let(:policy_1) { all_params }
      let(:policy_2) { all_params }

      it 'they should be equal' do
        expect(described_class.new(policy_1)).to eq described_class.new(policy_2)
      end
    end

    context 'and comparing two policies, one with different exchange_assigned_id' do
      let(:policy_1) { all_params }
      let(:policy_2) { all_params.merge(exchange_assigned_id: '68568') }

      it 'they should not be equal' do
        expect(described_class.new(policy_1)).not_to eq described_class.new(policy_2)
      end
    end

    context 'and comparing two policies, one with different person_name' do
      let(:policy_1) { all_params }
      let(:different_hbx_qhp_id) { '96667ME031005807' }
      let(:different_product) { { hbx_qhp_id: different_hbx_qhp_id, effective_year: effective_year, kind: kind } }
      let(:policy_2) { all_params.merge(product: different_product) }

      it 'they should not be equal' do
        expect(described_class.new(policy_1)).not_to eq described_class.new(policy_2)
      end
    end
  end
end
