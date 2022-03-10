# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Ledger::MarketplaceSegment do
  subject { described_class }

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

  describe 'with required arguments' do
    it 'should initialize' do
      expect(subject.new(required_params)).to be_a described_class
    end
  end

  describe 'Applying Comparable methods' do
    context 'and comparing two marketplace segments with same attributes' do
      let(:marketplace_segment_1) { all_params }
      let(:marketplace_segment_2) { all_params }

      it 'they should be equal' do
        expect(described_class.new(marketplace_segment_1)).to eq described_class.new(marketplace_segment_2)
      end
    end

    context 'and comparing two marketplace segments, one with different end_on date' do
      let(:marketplace_segment_1) { all_params }
      let(:different_end_on) { Date.new(2022, 11, 30) }
      let(:marketplace_segment_2) { all_params.merge(end_on: different_end_on) }

      it 'they should not be equal' do
        expect(described_class.new(marketplace_segment_1)).not_to eq described_class.new(marketplace_segment_2)
      end
    end
  end
end
