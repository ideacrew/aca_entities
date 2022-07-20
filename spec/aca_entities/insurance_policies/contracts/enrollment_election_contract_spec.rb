# frozen_string_literal: true

require 'spec_helper'
require 'support/shared_content/insurance_policies/contracts/shared_context'

RSpec.describe AcaEntities::InsurancePolicies::Contracts::EnrollmentElectionContract do
  include_context('insurance_policies_context')
  subject { described_class.new }

  let(:id) { '12345' }

  let(:enrollment_event_name) { initial_enrollment_event_name }
  let(:enrollment_event_payload) { { description: 'payload stub for enrollment event' } }
  let(:subscriber) { george_jetson[:enrolled_member] }
  let(:dependents) { [jane_jetson[:enrolled_member], judy_jetson[:enrolled_member]] }
  let(:effective_date) { january_1 }
  let(:end_on) { nil }
  let(:timestamps) { { created_at: moment, modified_at: moment } }

  let(:required_params) do
    {
      enrollment_event_name: enrollment_event_name,
      enrollment_event_payload: enrollment_event_payload,
      subscriber: subscriber,
      effective_date: effective_date,
      end_on: end_on
    }
  end
  let(:optional_params) { { id: id, dependents: dependents, timestamps: timestamps } }

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
        enrollment_event_name: ['is missing'],
        enrollment_event_payload: ['is missing'],
        subscriber: ['is missing'],
        effective_date: ['is missing']
      }
    end
    it 'should pass validation' do
      result = subject.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end
end
