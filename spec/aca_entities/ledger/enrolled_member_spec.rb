# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Ledger::EnrolledMember do
  subject { described_class }

  let(:id) { '12345' }

  let(:hbx_id) { '987654' }
  let(:person_name) { { first_name: 'George', last_name: 'Jetson' } }
  let(:subscriber_hbx_id) { '1138345' }
  let(:member) { { hbx_id: hbx_id, person_name: person_name, subscriber_hbx_id: subscriber_hbx_id } }

  let(:insured_age) { 33 }
  let(:amount) { 875.22 }
  let(:premium) { { insured_age: insured_age, amount: amount } }

  let(:start_on) { Date.new(2022, 2, 1) }
  let(:end_on) { Date.new(2022, 2, 28) }

  let(:moment) { DateTime.now }
  let(:timestamps) { { created_at: moment, modified_at: moment } }

  let(:required_params) { { member: member, premium: premium, start_on: start_on } }
  let(:optional_params) { { id: id, end_on: end_on, timestamps: timestamps } }
  let(:all_params) { required_params.merge(optional_params) }

  describe 'With required arguments' do
    it 'should initialize' do
      expect(subject.new(required_params)).to be_a described_class
    end
  end

  describe 'Applying Comparable methods' do
    context 'and comparing two enrolled_members with same attributes' do
      let(:enrolled_member_1) { all_params }
      let(:enrolled_member_2) { all_params }

      it 'they should be equal' do
        expect(described_class.new(enrolled_member_1)).to eq described_class.new(enrolled_member_2)
      end
    end

    context 'and comparing two enrolled_members, one with different start_on' do
      let(:enrolled_member_1) { all_params }
      let(:different_start_on) { Date.new(2022, 2, 12) }
      let(:enrolled_member_2) { all_params.merge(start_on: different_start_on) }

      it 'they should not be equal' do
        expect(described_class.new(enrolled_member_1)).not_to eq described_class.new(enrolled_member_2)
      end
    end

    context 'and comparing two enrolled_members, one with different premium' do
      let(:enrolled_member_1) { all_params }
      let(:different_premium) { { insured_age: insured_age, amount: 414.89 } }
      let(:enrolled_member_2) { all_params.merge(premium: different_premium) }

      it 'they should not be equal' do
        expect(described_class.new(enrolled_member_1)).not_to eq described_class.new(enrolled_member_2)
      end
    end
  end
end
