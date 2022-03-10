# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Ledger::Member do
  subject { described_class }

  let(:id) { '12345' }
  let(:subscriber_hbx_id) { '987654' }
  let(:hbx_id) { '987654' }
  let(:insurer_assigned_id) { '555555' }
  let(:insurer_assigned_subscriber_id) { '555555' }
  let(:person_name) { { first_name: 'George', last_name: 'Jetson' } }
  let(:is_subscriber) { true }
  let(:is_tobacco_user) { false }

  let(:ssn) { '777665432' }
  let(:dob) { Date.new(1988, 3, 15) }
  let(:gender) { 'male' }

  let(:moment) { DateTime.now }
  let(:timestamps) { { created_at: moment, modified_at: moment } }

  let(:required_params) { { hbx_id: hbx_id, subscriber_hbx_id: subscriber_hbx_id, person_name: person_name } }
  let(:optional_params) do
    {
      id: id,
      ssn: ssn,
      dob: dob,
      gender: gender,
      is_subscriber: is_subscriber,
      is_tobacco_user: is_tobacco_user,
      insurer_assigned_id: insurer_assigned_id,
      insurer_assigned_subscriber_id: insurer_assigned_subscriber_id,
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
    context 'and comparing two members with same attributes' do
      let(:member_1) { all_params }
      let(:member_2) { all_params }

      it 'they should be equal' do
        expect(described_class.new(member_1)).to eq described_class.new(member_2)
      end
    end

    context 'and comparing two members, one with different ssn' do
      let(:member_1) { all_params }
      let(:member_2) { all_params.merge(ssn: '548784521') }

      it 'they should not be equal' do
        expect(described_class.new(member_1)).not_to eq described_class.new(member_2)
      end
    end

    context 'and comparing two members, one with different person_name' do
      let(:member_1) { all_params }
      let(:different_person_name) { { first_name: 'Scooby', last_name: 'Doo' } }
      let(:member_2) { all_params.merge(person_name: different_person_name) }

      it 'they should not be equal' do
        expect(described_class.new(member_1)).not_to eq described_class.new(member_2)
      end
    end
  end
end
