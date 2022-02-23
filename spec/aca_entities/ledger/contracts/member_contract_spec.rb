# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Ledger::Contracts::MemberContract do
  subject { described_class.new }

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
    let(:error_message) { { hbx_id: ['is missing'], subscriber_hbx_id: ['is missing'], person_name: ['is missing'] } }
    it 'should pass validation' do
      result = subject.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end
end
