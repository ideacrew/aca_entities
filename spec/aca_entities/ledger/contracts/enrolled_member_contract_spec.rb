# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Ledger::Contracts::EnrolledMemberContract do
  subject { described_class.new }

  let(:id) { '12345' }

  let(:hbx_id) { '987654' }
  let(:person_name) { { first_name: 'George', last_name: 'Jetson' } }
  let(:subscriber_hbx_id) { '1138345' }
  let(:dob) { Date.new(1982, 6, 1) }
  let(:member) { { hbx_id: hbx_id, person_name: person_name, subscriber_hbx_id: subscriber_hbx_id, dob: dob } }

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
    let(:error_message) { { member: ['is missing'], premium: ['is missing'], start_on: ['is missing'] } }
    it 'should pass validation' do
      result = subject.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end
end
